import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'password_change_controller.dart';

class PasswordChangePage extends GetView<PasswordChangeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().customAppBar(title: "Chỉnh sửa mật khẩu"),
      body: SingleChildScrollView(
        child: GetBuilder<PasswordChangeController>(
          init: PasswordChangeController(),
          builder: (PasswordChangeController controller) {
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        right: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: [
                        // mật khẩu cũ
                        // _passwordInputWidget(
                        //     context,
                        //     "Mật khẩu cũ",
                        //     controller.textEditOldPasswordController,
                        //     TextInputType.visiblePassword),

                        // Mất khẩu
                        _passwordInputWidget(
                            context,
                            "Mật khẩu",
                            controller.textEditPasswordController,
                            TextInputType.visiblePassword),

                        // Xác nhận mật khẩu
                        _passwordInputWidget(
                            context,
                            "Xác nhận mật khẩu",
                            controller.textEditRePasswordController,
                            TextInputType.visiblePassword),

                        // update button
                        _buttonUpdate(context),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ///
  /// input widget
  ///
  Widget _passwordInputWidget(
    BuildContext context,
    String? label,
    TextEditingController controllers,
    TextInputType extInputType,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.025)),
      child: TextField(
        textInputAction: TextInputAction.next,
        textAlignVertical: TextAlignVertical.center,
        controller: controllers,
        keyboardType: extInputType,
        cursorColor: ColorResources.PRIMARY,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: DeviceUtils.getScaledSize(context, 0.025),
              vertical: DeviceUtils.getScaledSize(context, 0.038)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResources.PRIMARY)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResources.GREY)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResources.GREY)),
          hintText: label,
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }

  ///
  /// button tiếp tục
  ///
  Widget _buttonUpdate(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onBtnUpdateClick(context),
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledSize(context, 0.035)),
        padding: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledSize(context, 0.035),
            horizontal: DeviceUtils.getScaledSize(context, 0.03)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF61A63C),
              Color(0xFF61A63C),
              Color(0xFF61A63C),
            ],
          ),
        ),
        child: const Text(
          "Cập nhật",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
