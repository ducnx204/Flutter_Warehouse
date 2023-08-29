import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/district_model.dart';
import 'package:template/data/model/body/image_model.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/product_condition_model.dart';
import 'package:template/data/model/body/province_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class PaymentController extends GetxController {
  GetIt sl = GetIt.instance;

  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  UserModel userModel = UserModel();
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  final OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  final ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();

  ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();

  final addressTextController = TextEditingController();

  String? province;
  String? district;

  String? provinceId;
  String? districtId;

  List<ProvinceModel> provinceModelList = [];
  List<DistrictModel> districtModelList = [];

  List<String> provinceList = [];
  List<String> districtList = [];

  bool isLoading = true;

  bool isLoadingMore = false;
  // image picker
  File? image;

  // quanlity product
  RxInt qualityProduct = 1.obs;

  // It is mandatory initialize with one value from listType
  List<int> orderList = [];

  int sum = 0;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    getProvince();
  }

  @override
  void onClose() {
    super.onClose();
    addressTextController.dispose();
  }

  ///
  ///get user info
  ///
  void getUserInfo() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userProvider.find(
          id: value!,
          onSuccess: (data) {
            userModel = data;
            update();
          },
          onError: (error) {
            print(error);
          });
    });
  }

  ///
  ///get province
  ///
  void getProvince() {
    provinceProvider.all(onSuccess: (value) {
      provinceModelList = value;
      value.map((item) {
        provinceList.add(item.name!);
      }).toList();
      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
    });
  }

  ///
  ///
  ///
  void setSelectedProvince(String? value) {
    district = null;
    districtList.clear();
    province = value;
    provinceId = provinceModelList[
            provinceModelList.indexWhere((element) => element.name == value)]
        .id;
    getDistrict(provinceId!);
    update();
  }

  ///
  ///get district
  ///
  void getDistrict(String id) {
    districtProvider.paginate(
        page: 1,
        limit: 100,
        filter: "idProvince=$id",
        onSuccess: (value) {
          districtModelList = value;
          value.map((item) {
            if (item.id == userModel.districtOrder) {
              district = item.name;
            }
            districtList.add(item.name!);
          }).toList();

          update();
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///set selected district
  ///
  void setSelectedDistrict(String? value) {
    district = value;
    districtId = districtModelList[districtModelList
            .indexWhere((element) => element.name!.trim() == value!.trim())]
        .id;
    update();
  }

  ///
  ///save address
  ///
  void changeAddress() {
    if (userModel.provinceOrder!.isEmpty ||
        userModel.districtOrder!.isEmpty ||
        addressTextController.text.isEmpty) {
      Get.snackbar("Thất bại!", "Vui lòng nhập đủ các trường");
    } else {
      print("addressController.text: ${addressTextController.text}");

      // update address

      userProvider.addressOrderUpdate(
          data: UserModel(
            id: userModel.id,
            address: userModel.address,
            avatar: userModel.avatar,
            born: userModel.born,
            citizenIdentification: userModel.citizenIdentification,
            email: userModel.email,
            phone: userModel.phone,
            fullname: userModel.fullname,
            idOptionalRole: userModel.idOptionalRole,
            idRole: userModel.idRole,
            idUser: userModel.idUser,
            imageCitizenIdentification1: userModel.imageCitizenIdentification1,
            imageCitizenIdentification: userModel.imageCitizenIdentification,
            paymentProofImage: userModel.paymentProofImage,
            sex: userModel.sex,
            status: userModel.status,
            username: userModel.username,
            addressCurrent: userModel.addressCurrent,
            addressOrder: addressTextController.text,
            districtOrder: districtId,
            provinceOrder: provinceId,
          ),
          onSuccess: (value) {},
          onError: (error) {
            print(error);
          });
      //back to cart
      Get.back(result: true);
      update();
    }
  }

  ///
  /// pick image
  ///
  Future pickImage() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker == null) return;
      image = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// upload image
  ///
  void onBtnFinishTap(
    BuildContext context,
    UserModel user,
    bool isRegister,
    List<ProductConditionModel> items,
  ) {
    if (image != null) {
      EasyLoading.show(status: 'loading...');

      // image provider
      imageProvider.add(
        file: image!,
        onSuccess: (image) {
          print('link image ${image.data}');

          // kiểm tra là đăng ký mới hay là đã có tài khoản
          if(isRegister){
            // gen username
            userProvider.genUsername(onSuccess: (genModel) {
              user.paymentProofImage = image.data;
              user.username = genModel.username;

              // add api user provider
              userProvider.add(
                data: user,
                onSuccess: (userModel) {
                  print("User added");

                  // tạo đơn hàng
                  final OrderModel order = OrderModel(
                    idUser: userModel.id,
                    address: userModel.address,
                    idDistrict: districtId,
                    idProvince: provinceId,
                    idWarehouse: '0',
                    imagePayment: image.data,
                    statusOrder: '1',
                    statusPayment: '1',
                    totalPrice: convertSum(items),
                    userAccept: '0',
                    description: 'Đơn hàng mới',
                    discountPrice: "0",
                  );

                  // add api order provider
                  orderProvider.add(
                    data: order,
                    onSuccess: (model) {
                      // add Order Item To database
                      _addOrderItemToDB(model.id!, items);

                      Get.back();
                      Get.back();
                      Get.back();

                      EasyLoading.dismiss();
                      showAnimatedDialog(
                        context,
                        MyDialog(
                          icon: Icons.check,
                          title: "Hoàn tất đăng ký ID ${genModel.username}",
                          description:
                          "Mã ID của bạn là ${genModel.username}\nVui lòng đợi admin active",
                        ),
                        dismissible: false,
                        isFlip: true,
                      );
                    },
                    onError: (error) {
                      print(error);
                    },
                  );
                },
                onError: (error) {
                  print(error);
                },
              );
            }, onError: (error) {
              print(error);
            });
          }else{
            // đã có tài khoản rồi

            final OrderModel order = OrderModel(
              idUser: userModel.id,
              address: userModel.address,
              idDistrict: districtId,
              idProvince: provinceId,
              idWarehouse: '0',
              imagePayment: image.data,
              statusOrder: '1',
              statusPayment: '1',
              totalPrice: convertSum(items),
              userAccept: '0',
              description: 'Đơn hàng mới',
              discountPrice: "0",
            );

            // add api order provider
            orderProvider.add(
              data: order,
              onSuccess: (model) {
                // add Order Item To database
                _addOrderItemToDB(model.id!, items);

                Get.back();
                Get.back();
                Get.back();

                EasyLoading.dismiss();
                showAnimatedDialog(
                  context,
                  const MyDialog(
                    icon: Icons.check,
                    title: "Mua đơn hàng thành công",
                    description:
                    "Đơn hàng của bạn đã đặt hàng thành công",
                  ),
                  dismissible: false,
                  isFlip: true,
                );
              },
              onError: (error) {
                print(error);
              },
            );
          }

        },
        onError: (error) {
          print(error);
        },
      );
    } else {
      _showSnakebar(
        "Upload hình lỗi",
        "Bạn cần phải bổ sung hình trước khi thanh toán",
        2,
      );
    }
  }

  ///
  /// _add order item to database
  ///
  void _addOrderItemToDB(String orderId, List<ProductConditionModel> items) {
    // duyệt các sản phẩm
    items.forEach((element) {
      final OrderItemModel model = OrderItemModel(
        idOrder: orderId,
        idProduct: element.id,
        price: (element.amount * element.quality).toString(),
        quantity: element.quality.toString(),
      );

      // add api của order item
      orderItemProvider.add(
        data: model,
        onSuccess: (value) {},
        onError: (error) {
          print(error);
        },
      );

      print("Order item added");
    });
  }

  ///
  /// convert sum number to sum string
  ///
  String convertSum(List<ProductConditionModel> items) {
    return sumCalculator(items).toString();
  }

  ///
  /// tính tổng tiền
  ///
  int sumCalculator(List<ProductConditionModel> items) {
    int sum = 0;

    // tổng (số lượng và đơn giá) của các sản phẩm
    items.forEach((element) {
      sum += element.quality * element.amount;
    });
    return (sum * 0.75).toInt();
  }

  ///
  /// show snackbar
  ///
  void _showSnakebar(String title, String message, int seconds) {
    Get.snackbar(
      title, // title
      message, // message
      backgroundColor: const Color(0xffFFEBEE),
      icon: const Icon(Icons.error_outline),
      shouldIconPulse: true,
      isDismissible: true,
      duration: Duration(seconds: seconds),
    );
  }
}
