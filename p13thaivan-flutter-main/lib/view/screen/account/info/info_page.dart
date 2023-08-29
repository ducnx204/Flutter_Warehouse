import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'info_controller.dart';

class EditInfoPage extends GetView<EditInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().customAppBar(title: "Chỉnh sửa thông tin cá nhận"),
      body: SingleChildScrollView(
          child: GetBuilder<EditInfoController>(
              init: EditInfoController(),
              builder: (EditInfoController controller) {
                if(controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

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
                            // Mã giới thiệu
                            _normalInputWidget(
                              context,
                              "Họ và tên",
                              controller.textEditFullnameController,
                              TextInputType.text,
                            ),

                            // Địa chỉ liên lạc
                            _addressInputWidget(
                              context,
                              "Địa chỉ liên lạc",
                              controller.textEditAddressController,
                              TextInputType.text,
                            ),
                            // avatar
                            _uploadAvatar(context),

                            // tiếp tục button
                            _buttonUpdate(context),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }

  ///
  /// input widget
  ///
  Widget _normalInputWidget(BuildContext context, String? label,
      TextEditingController controllers, TextInputType extInputType) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.025)),
      child: TextField(
        textInputAction: TextInputAction.next,
        textAlignVertical: TextAlignVertical.center,
        controller: controllers,
        keyboardType: extInputType,
        cursorColor: ColorResources.PRIMARY,
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
  ///  address input widget
  ///
  Widget _addressInputWidget(BuildContext context, String? label,
      TextEditingController controllers, TextInputType extInputType) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.025)),
      child: TextField(
        textInputAction: TextInputAction.done,
        textAlignVertical: TextAlignVertical.center,
        controller: controllers,
        keyboardType: extInputType,
        cursorColor: ColorResources.PRIMARY,
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
  /// upload avatar
  ///
  Widget _uploadAvatar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.05),
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Tải lên avatar",
                style: Dimensions.fontSizeStyle16w600()
                    .copyWith(color: ColorResources.BLACK),
              ),
            ],
          ),

          SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),

          // hình ảnh avatar
          GestureDetector(
            onTap: () => controller.onAvatarPicker(),
            child: Container(
              height: DeviceUtils.getScaledSize(context, 0.382),
              width: DeviceUtils.getScaledSize(context, 0.509),
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledSize(
                      context, controller.avatarFile != null ? 0 : 0.101)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: controller.avatarFile != null
                    ? null
                    : Border.all(width: 2, color: Colors.grey),
              ),
              child: controller.avatarFile != null
                  ? Image.file(
                      controller.avatarFile!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    )
                  : (controller.avatarPath != null)
                      ? Image.network(
                          controller.avatarPath!,
                          fit: BoxFit.fitHeight,
                        )
                      : Container(),
            ),
          )
        ],
      ),
    );
  }

  ///
  /// button cập nhật
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
