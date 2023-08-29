import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/image_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/order_item_response_model.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';
import 'package:template/view/screen/dashboard/dashboard_page.dart';

class CheckoutController extends GetxController {
  GetIt sl = GetIt.instance;
  File? image;
  ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();
  ImageUpdateModel? imageUpdateModel;

  UserProvider userProvider = GetIt.I.get<UserProvider>();
  UserModel? userModel;

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  List<OrderItemResponseModel> selectedProductList = [];

  ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  String? province;

  DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();
  String? district;

  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  int price = 0;

  bool isLoading = true;
  bool isLoadingImage = false;
  bool isLoadingCheckout = false;

  String? orderId;

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().orderId.then((value) => orderId = value);
    loadSelectedProduct();
  }

  ///
  ///load selected product
  ///
  void loadSelectedProduct() {
    sl
        .get<SharedPreferenceHelper>()
        .orderId
        .then((value) => orderItemProvider.findByIdOrder(
            page: 1,
            limit: 100,
            idOrder: Get.parameters['idOrder'].toString(),
            onSuccess: (value) {
              selectedProductList = value;
              calculatorPrice();
              isLoading = false;
              update();
            },
            onError: (error) {
              print(error);
              update();
            }));
  }

  ///
  ///calculator price
  ///
  void calculatorPrice() {
    for (var i = 0; i < selectedProductList.length; i++) {
      price += int.parse(selectedProductList[i].quantity!) *
          int.parse(selectedProductList[i].idProduct!.prices!);
    }
    update();
  }

  ///
  ///pick image
  ///
  Future pickImage() async {
    isLoadingImage = true;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      isLoadingImage = false;
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///get address
  ///
  void getAddress() {}

  ///
  ///on Done
  ///
  void onClickDoneBtn(
    BuildContext context,
  ) {
    if (image != null) {
      isLoadingCheckout = true;

      // upload image trước
      imageProvider.add(
          file: image!,
          onSuccess: (image) {
            imageUpdateModel = image;

            // sau khi upload image thành công
            sl.get<SharedPreferenceHelper>().userId.then((dataUserId) {
              //get idUser from SharedPreferenceHelper
              userProvider.find(
                  id: dataUserId!,
                  onSuccess: (value) {
                    //checkout
                    orderProvider.update(
                        data: OrderModel(
                            id: orderId,
                            idUser: dataUserId,
                            statusOrder: "1",
                            statusPayment: "1",
                            description: "Đơn hàng mới",
                            address: value.addressOrder,
                            idDistrict: Get.parameters['idDistrict'],
                            idProvince: Get.parameters['idProvince'],
                            discountPrice: "0",
                            idWarehouse: "0",
                            userAccept: "0",
                            totalPrice: price.toString(),
                            imagePayment: imageUpdateModel!.data),
                        onSuccess: (value) {
                          sl.get<SharedPreferenceHelper>().removeOrderId();
                          Get.back();
                          Get.back();
                          Get.back();
                          Get.back();
                          Future.delayed(const Duration(seconds: 2))
                              .then((value) {
                            isLoadingCheckout = false;
                            update();
                          });
                          showAnimatedDialog(
                              context,
                              const MyDialog(
                                icon: Icons.check,
                                title: "Hoàn tất",
                                description: "Đặt hàng thành công",
                              ),
                              dismissible: false,
                              isFlip: true);
                        },
                        onError: (error) {
                          print(error);
                          update();
                        });
                  },
                  onError: (error) {
                    print(error);
                  });
            });

            update();
          },
          onError: (error) {
            print(error);
            update();
          });
    } else {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        isLoadingCheckout = false;

        Get.snackbar(
          "Thất bại",
          "Vui lòng tải lên hình ảnh thanh toán",
          colorText: ColorResources.RED,
          backgroundGradient: const LinearGradient(colors: [
            Color(0xffffb8b3),
            Color(0xffff9b94),
            Color(0xffffb8b3),
          ], begin: Alignment(2, -1), end: Alignment(1, 5)),
        );
        update();
      });
    }
  }
}
