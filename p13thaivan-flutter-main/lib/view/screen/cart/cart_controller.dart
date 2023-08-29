import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/category_model.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/order_item_response_model.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

class CartController extends GetxController {
  GetIt sl = GetIt.instance;

  final qualityController = TextEditingController();
  final focusNode = FocusNode();

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  CategoryProvider categorieProvider = GetIt.I.get<CategoryProvider>();

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  List<OrderItemResponseModel> orderItemProductList = [];

  ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();
  String provinceName = "";
  String districtName = "";

  UserProvider userProvider = GetIt.I.get<UserProvider>();
  UserModel? userModel;

  List<CategoryModel> categoryModelList = [];

  String idUser = '';

  bool isLastProduct = false;
  bool isLoading = true;
  bool isLoadingQuality = false;
  bool isReloadData = false;

  int price = 0;

  //số lượng sản phẩm
  List<int> qualityProduct = [];

  @override
  void onInit() {
    super.onInit();

    // get all Categories
    getAllCategories();

    getAddress();
  }

  ///
  /// get All Categories
  ///
  void getAllCategories() {
    categorieProvider.all(onSuccess: (value) {
      categoryModelList = value;

      // load Selected Product
      loadSelectedProduct();

      update();
    }, onError: (error) {
      print(error);
    });
  }

  ///
  ///load list selected product
  ///
  void loadSelectedProduct() {
    orderItemProductList = [];
    if (Get.parameters['idOrder'].toString() != "null") {
      // lấy thông tin sản phẩm từ idOrder
      orderItemProvider.findByIdOrder(
          page: 1,
          limit: 100,
          idOrder: Get.parameters['idOrder'].toString(),
          onSuccess: (value) {
            orderItemProductList.clear();
            orderItemProductList = value;
            value
                .map((quanlity) =>
                    qualityProduct.add(int.parse(quanlity.quantity!)))
                .toList();

            calculatorPrice();
          },
          onError: (error) {
            print(error);
            update();
          });
    } else {
      isLoading = false;
      update();
    }
  }

  ///
  ///xoá khỏi giỏ hàng
  ///
  void deleteItem(int index) {
    Get.defaultDialog(
        middleText: "Bạn có chắc muốn xóa sản phẩm",
        textCancel: "Hủy",
        textConfirm: "Đồng ý",
        cancelTextColor: ColorResources.BLACK,
        confirmTextColor: ColorResources.RED,
        onConfirm: () {
          isLoadingQuality = true;
          update();

          //xoá sản phẩm
          orderItemProvider.delete(
              id: orderItemProductList[index].id.toString(),
              onSuccess: (value) {
                loadSelectedProduct();
                isReloadData = true;
                isLoadingQuality = false;
                update();
              },
              onError: (error) {
                print(error);
                update();
              });
          Get.back();
        });
  }

  ///
  ///calculator price
  ///
  void calculatorPrice() {
    price = 0;
    for (var i = 0; i < orderItemProductList.length; i++) {
      // caculator discount price
      final int percentDiscount = int.parse(categoryModelList
          .where((item) =>
              item.id == orderItemProductList[i].idProduct!.idCategory)
          .toList()[0]
          .discount
          .toString());

      // tính giá sản phẩm giảm theo từng danh mục
      orderItemProductList[i].idProduct!.prices =
          (double.parse(orderItemProductList[i].idProduct!.prices.toString()) -
                  percentDiscount /
                      100 *
                      double.parse(
                          orderItemProductList[i].idProduct!.prices.toString()))
              .toString();

      // tính tổng tiền dựa vào giá đã giảm nhân với số lượng
      price +=
          double.parse(orderItemProductList[i].idProduct!.prices.toString())
                  .toInt() *
              int.parse(orderItemProductList[i].quantity.toString());
    }

    update();
  }

  ///
  /// tăng số lượng
  ///
  void incrementQuality(int index) {
    qualityProduct[index] += 1;

    orderItemProvider.update(
        data: OrderItemModel(
            id: orderItemProductList[index].id,
            idOrder: Get.parameters['idOrder'].toString(),
            quantity: qualityProduct[index].toString(),
            price: double.parse(orderItemProductList[index].idProduct!.prices!)
                .toInt()
                .toString()),
        onSuccess: (value) {
          loadSelectedProduct();
        },
        onError: (error) {});

    update();
  }

  ///
  /// giảm số lượng
  ///
  void decrementQuality(int index) {
    if (qualityProduct[index] > 1) {
      qualityProduct[index] -= 1;

      orderItemProvider.update(
          data: OrderItemModel(
              id: orderItemProductList[index].id,
              idOrder: Get.parameters['idOrder'].toString(),
              quantity: qualityProduct[index].toString(),
              price:
                  double.parse(orderItemProductList[index].idProduct!.prices!)
                      .toInt()
                      .toString()),
          onSuccess: (value) {
            loadSelectedProduct();
          },
          onError: (error) {});
    }
  }

  ///
  ///reload price
  ///
  void calculatorPriceReload(int index) {
    // for (var i = 0; i < orderItemProductList.length; i++) {
    //   price = qualityProduct[index] *
    //       int.parse(orderItemProductList[i].idProduct!.prices!);
    //   price += price;
    // }
    // update();
  }

  ///
  ///get address from iUser
  ///
  void getAddress() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      //lấy thông tin
      userProvider.find(
          id: value!,
          onSuccess: (data) {
            userModel = data;

            // nếu địa chỉ nhận hàng khác rỗng thì hiển thị lên màn hình
            if (data.addressOrder != "" ||
                data.provinceOrder != "" ||
                data.districtOrder != "") {
              //lấy tên tỉnh từ id
              provinceProvider.find(
                  id: data.provinceOrder!,
                  onSuccess: (values) {
                    provinceName = values.name!;
                    update();
                  },
                  onError: (error) {});
              //lấy tên huyện từ id
              districtProvider.find(
                  id: data.districtOrder!,
                  onSuccess: (values) {
                    districtName = values.name!;
                    print(districtName);
                    update();
                  },
                  onError: (error) {});
            }
            Future.delayed(const Duration(seconds: 1)).then((value) {
              isLoading = false;
              update();
            });
          },
          onError: (error) {
            print(error);
          });
    });
  }

  ///
  ///thay đổi địa chỉ
  ///
  void onAddressClick() {
    Get.toNamed(AppRoutes.ADDRESS)!.then((value) {
      //nếu có thực hiện thay đổi địa chỉ thì reload lại
      if (value == true) {
        getAddress();
        update();
      }
    });
  }

  ///
  ///thanh toán
  ///
  void onCheckoutClick() {
    //kiểm tra điều kiện trước khi thanh toán
    if (userModel!.addressOrder == '' ||
        userModel!.districtOrder == '' ||
        userModel!.provinceOrder == '') {
      /// show snackbar
      Get.snackbar(
        "Vui lòng kiểm tra lại", // title
        "Nhập địa chỉ nhận hàng", // message
        backgroundColor: const Color(0xffFFEBEE),
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      );
    } else {
      sl.get<SharedPreferenceHelper>().orderId.then((value) => Get.toNamed(
          "${AppRoutes.CHECKOUT}?idOrder=$value&idProvince=${userModel!.provinceOrder}&idDistrict=${userModel!.districtOrder}"));
    }
  }

  ///
  ///get back
  ///
  void onGetBack() {
    Get.back(result: isReloadData);
  }
}
