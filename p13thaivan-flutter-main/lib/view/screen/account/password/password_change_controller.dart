import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class PasswordChangeController extends GetxController {
  GetIt sl = GetIt.instance;

  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();
  bool isLoading = false;
  // TextEditingController textEditOldPasswordController = TextEditingController();
  TextEditingController textEditPasswordController = TextEditingController();
  TextEditingController textEditRePasswordController = TextEditingController();

  ///
  /// on button Update click
  ///
  void onBtnUpdateClick(BuildContext context) {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      // kiểm tra mã giới thiệu đúng không
      userProvider.find(
          id: value!,
          onSuccess: (userData) {
            // print(userData.toJson());
            // validate input user
            final bool isValid = _checkValidateInput();

            if (isValid) {
              final Map<String, String> data = {
                "id": userData.id!,
                "password": textEditPasswordController.text,
              };
              userProvider.infoUpdate(
                data: data,
                onSuccess: (user) {
                  // Thực hiện update
                  Get.back();
                  print("Password updated");
                  showAnimatedDialog(
                    context,
                    const MyDialog(
                      icon: Icons.check,
                      title: "Hoàn tất",
                      description: "Cập nhật hoàn tất",
                    ),
                    dismissible: false,
                    isFlip: true,
                  );
                  EasyLoading.dismiss();
                  update();
                },
                onError: (error) {
                  print(error);
                  update();
                },
              );
            }
          },
          onError: (error) {
            print(error);
            update();
          });
    });
  }

  ///
  /// check validate input
  ///
  bool _checkValidateInput() {
    // if (textEditOldPasswordController.text == '') {
    //   // mật khẩu cũ
    //   _showSnakebar('Vui lòng kiểm tra lại!', 'Mật khẩu cũ không được rỗng', 3);
    //   return false;
    // }

    if (textEditPasswordController.text == '') {
      // mật khẩu mới
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Mật khẩu mới không được trống', 3);
      return false;
    }

    if (textEditPasswordController.text.length < 6) {
      // mật khẩu mới
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Mật khẩu phải ít nhất 6 ký tự', 3);
      return false;
    }

    if (textEditPasswordController.text != textEditRePasswordController.text) {
      // xem thử mới và nhập lại giống nhau không
      _showSnakebar('Vui lòng kiểm tra lại!',
          'Mật khẩu nhập lại không giống với mật khẩu mới', 3);
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
      backgroundColor: const Color(0xffFFEBEE),
      icon: const Icon(Icons.error_outline),
      shouldIconPulse: true,
      isDismissible: true,
      duration: Duration(seconds: seconds),
    );
  }
}
