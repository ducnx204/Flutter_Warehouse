import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:template/view/screen/register/order_condition/order_condition_page.dart';

class InformationUserController extends GetxController {
  GetIt sl = GetIt.instance; 

  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();
  bool isLoading = false;

  TextEditingController textEditInviteUsernameController =
      TextEditingController();
  TextEditingController textEditPasswordController = TextEditingController();
  TextEditingController textEditRePasswordController = TextEditingController();
  TextEditingController textEditPhoneController = TextEditingController();
  TextEditingController textEditFullnameController = TextEditingController();
  TextEditingController textEditCmndController = TextEditingController();
  TextEditingController textEditAddressController = TextEditingController();

  String? ngaySinh = 'Ngày sinh';
  String? born = '';

  // value dropdown
  String? gender;

  // cmnd front file
  File? avatarFile;

  // cmnd front file
  File? cmndFrontFile;

  // cmnd back file
  File? cmndBackFile;

  var focusNodeMaGioiThieu = FocusNode();

  @override
  void onInit() {
    focusNodeMaGioiThieu.addListener(() {
      // listen lost focus
      if (!focusNodeMaGioiThieu.hasFocus) {
        // kiểm tra mã nhập vào có đúng không

        // nếu sai thì cần phải show lên thông báo là sai mã
      }
    });
    super.onInit();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   addressTextController.dispose();
  // }

  ///
  /// on ngay sinh change
  ///
  void onNgaySinhChange(DateTime? value) {
    ngaySinh = DateConverter.isoStringToVNDateOnly(value.toString());
    born = DateConverter.formatDate(value!);
    update();
  }

  ///
  /// on avatar picker
  ///
  Future onAvatarPicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker == null) return;
      avatarFile = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on CMND front picker
  ///
  Future onCmndFrontPicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker == null) return;
      cmndFrontFile = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on CMND back picker
  ///
  Future onCmndBackPicker() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker == null) return;
      cmndBackFile = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// on gender change
  ///
  void onGenderChange(String value) {
    gender = value;
    update();
  }

  ///
  /// on button continue click
  ///
  void onBtnContinueClick() {
    // validate data input
    // kiểm tra mã giới thiệu có nhập hay chưa
    if (textEditInviteUsernameController.text.toString() == '') {
      _showSnakebar('Vui lòng kiểm tra lại!', 'Mã giới thiệu không tồn tại', 3);
      return;
    }

    // kiểm tra mã giới thiệu đúng không
    userProvider.checkUsernameExists(
        username: textEditInviteUsernameController.text.toString(),
        onSuccess: (userData) {
          // validate input user
          final bool isValid = _checkValidateInput(userData.idUser.toString());

          if (isValid) {
            // create model
            final UserModel user = UserModel();
            user.idUser = userData.id;
            user.username = 'ytp3xxx';
            user.password = textEditPasswordController.text;
            user.phone = textEditPhoneController.text;
            user.fullname = textEditFullnameController.text;
            user.sex = gender;
            user.born = born;
            user.citizenIdentification = textEditCmndController.text;
            user.address = textEditAddressController.text;
            user.idRole = app_constants.ID_CONG_TAC_VIEN;
            user.idOptionalRole = "0";
            user.addressCurrent = '';
            //địa chỉ nhận hàng
            user.addressOrder = '';
            user.districtOrder = '';
            user.provinceOrder = '';

            // chờ duyệt
            user.status = '1';

            // show loading
            EasyLoading.show(status: 'loading...');

            imageProvider.add(
              file: avatarFile!,
              onSuccess: (imageFront) {
                // mặt trước cmnd
                user.avatar = imageFront.data;

                // upload cmnd
                imageProvider.add(
                  file: cmndFrontFile!,
                  onSuccess: (imageFront) {
                    // mặt trước cmnd
                    user.imageCitizenIdentification = imageFront.data;

                    imageProvider.add(
                        file: cmndFrontFile!,
                        onSuccess: (imageBack) {
                          // mặt sau cmnd
                          user.imageCitizenIdentification1 = imageBack.data;

                          // hide loading
                          EasyLoading.dismiss();

                          // sent data user to order condition page
                          Get.to(OrderConditionPage(
                            user: user,
                            isRegister: true,
                            isCondition: true,
                          ));
                        },
                        onError: (error) {
                          print(error);
                          update();
                        });
                  },
                  onError: (error) {
                    print(error);
                    update();
                  },
                );
              },
              onError: (error) {
                print(error);
                update();
              },
            );

            // sent model to order information page
          }
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  ///
  /// check validate input
  ///
  bool _checkValidateInput(String idUser) {
    // mã giới thiệu ko tồn tại
    if (idUser == 'null') {
      _showSnakebar('Vui lòng kiểm tra lại!', 'Mã giới thiệu không tồn tại', 3);
      return false;
    } else {
      // kiểm tra mật khẩu trùng không và đủ độ dài không
      if (textEditPasswordController.text.length < 6) {
        _showSnakebar('Vui lòng kiểm tra lại!', 'Mật khẩu ít nhất 6 ký tự', 3);
        return false;
      } else {
        if (textEditPasswordController.text !=
            textEditRePasswordController.text) {
          _showSnakebar('Vui lòng kiểm tra lại!',
              'Mật khẩu và nhập lại mật khẩu đang không trùng', 3);
          return false;
        }
      }

      // các thông tin còn lại khác null là được
      if (textEditPhoneController.text == '') {
        // phone
        _showSnakebar(
            'Vui lòng kiểm tra lại!', 'Số điện thoại không được để trống', 3);
        return false;
      }

      if (textEditFullnameController.text == '') {
        // Fullname
        _showSnakebar(
            'Vui lòng kiểm tra lại!', 'Họ và tên không được để trống', 3);
        return false;
      }

      if (gender == '') {
        // gender
        _showSnakebar('Vui lòng kiểm tra lại!', 'Giới không được để trống', 3);
        return false;
      }

      if (ngaySinh == 'Ngày sinh') {
        // Born
        _showSnakebar(
            'Vui lòng kiểm tra lại!', 'Ngày sinh không được để trống', 3);
        return false;
      }

      if (textEditCmndController.text == '') {
        // cmnd
        _showSnakebar(
            'Vui lòng kiểm tra lại!', 'CMND/CCCD không được để trống', 3);
        return false;
      }
    }

    if (avatarFile == null) {
      // cmnd front
      _showSnakebar('Vui lòng kiểm tra lại!', 'Cần thêm avatar', 3);
      return false;
    }

    if (cmndFrontFile == null) {
      // cmnd front
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Cần thêm CMND/CCCD mặt trước', 3);
      return false;
    }

    if (cmndBackFile == null) {
      // cmnd back
      _showSnakebar('Vui lòng kiểm tra lại!', 'Cần thêm CMND/CCCD mặt sau', 3);
      return false;
    }

    if (textEditAddressController.text == '') {
      // Địa chỉ liên lạc
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Địa chỉ liên lạc không được để trống', 3);
      return false;
    }

    return true;
  }

  ///
  /// show snackbar
  ///
  void _showSnakebar(String title, String message, int seconds) {
    Get.snackbar(
      title, // title
      message, // message
      backgroundColor: Color(0xffFFEBEE),
      icon: const Icon(Icons.error_outline),
      shouldIconPulse: true,
      isDismissible: true,
      duration: Duration(seconds: seconds),
    );
  }
}
