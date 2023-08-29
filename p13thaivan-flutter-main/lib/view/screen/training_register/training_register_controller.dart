import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/educate_model.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/educate_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class TrainingRegisterController extends GetxController {
  final fullnameTexController = TextEditingController();
  final bornTexController = TextEditingController();
  final addressTexController = TextEditingController();
  final phoneTexController = TextEditingController();
  final positionTexController = TextEditingController();
  final addressLearningTexController = TextEditingController();
  final contentTexController = TextEditingController();
  final dateStartWorkingTexController = TextEditingController();
  final dateRegistrationTexController = TextEditingController();

  EducateProvider educateProvider = GetIt.I.get<EducateProvider>();

  UserProvider userProvider = GetIt.I.get<UserProvider>();

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  ///
  ///auto fill info user
  ///
  void getUserInfo() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      print(value);
      userProvider.find(
          id: value!,
          onSuccess: (value) {
            fullnameTexController.text = value.fullname!;
            bornTexController.text =
                DateConverter.isoStringToVNDateOnly(value.born!);
            addressTexController.text = value.address!;
            phoneTexController.text = value.phone!;
            isLoading = false;
            update();
          },
          onError: (error) {
            print(error);
          });
    });
  }

  ///
  ///on click btn register
  ///
  void onClickBtnRegister(BuildContext context) {
    // validate input
    final bool isValid = _checkValidateInput();

    //register
    if (isValid) {
      final educateModel = EducateModel();
      educateModel.fullname = fullnameTexController.text;
      educateModel.born = bornTexController.text;
      educateModel.address = addressTexController.text;
      educateModel.phone = phoneTexController.text;
      educateModel.position = positionTexController.text;
      educateModel.addressLearning = addressLearningTexController.text;
      educateModel.content = contentTexController.text;
      educateModel.dateStartWorking = dateStartWorkingTexController.text;
      educateModel.dateRegistration = dateRegistrationTexController.text;
      educateProvider.add(
          data: educateModel,
          onSuccess: (value) {
            Get.offNamed(AppRoutes.ACCOUNT);
            showAnimatedDialog(
                context,
                const MyDialog(
                  icon: Icons.check,
                  title: "Hoàn tất",
                  description: "Đăng ký thành công",
                ),
                dismissible: false,
                isFlip: true);
          },
          onError: (error) {
            print(error);
          });
    }
  }

  ///
  /// check validate input
  ///
  bool _checkValidateInput() {
    if (fullnameTexController.text == '') {
      // Fullname
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Họ và tên không được để trống', 3);
      return false;
    }

    if (bornTexController.text == '') {
      // Born
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Ngày sinh không được để trống', 3);
      return false;
    }

    if (addressTexController.text == '') {
      // địa chỉ
      _showSnakebar('Vui lòng kiểm tra lại!', 'Địa chỉ không được để trống', 3);
      return false;
    }

    if (phoneTexController.text == '') {
      // phone
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Số điện thoại không được để trống', 3);
      return false;
    }

    if (positionTexController.text == '') {
      // Chức vụ
      _showSnakebar('Vui lòng kiểm tra lại!',
          'Chức vụ Cộng tác viên không được để trống', 3);
      return false;
    }

    if (addressLearningTexController.text == '') {
      // Địa điểm muốn đăng ký
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Địa điểm không được để trống', 3);
      return false;
    }

    if (contentTexController.text == '') {
      // Nội dung muốn học
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Nội dung không được để trống', 3);
      return false;
    }

    if (dateStartWorkingTexController.text == '') {
      // Ngày bắt đầu
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Thời gian bắt đầu không được để trống', 3);
      return false;
    }
    if (dateRegistrationTexController.text == '') {
      // ngày đăng ký
      _showSnakebar(
          'Vui lòng kiểm tra lại!', 'Thời gian đăng ký không được để trống', 3);
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
