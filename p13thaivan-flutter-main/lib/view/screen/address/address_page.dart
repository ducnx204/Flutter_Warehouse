import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/address/address_controller.dart';

class AddressPage extends GetView<AddressController> {
  ///
  /// input Widget
  ///
  Widget _inputWidget(BuildContext context,
      {required TextEditingController textController, required String hint}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      child: GetBuilder<AddressController>(
          init: AddressController(),
          builder: (controller) {
            return TextField(
              textInputAction: TextInputAction.done,
              textAlignVertical: TextAlignVertical.center,
              controller: textController,
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
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARY)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ColorResources.GREY)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ColorResources.GREY)),
                hintText: hint,
                filled: true,
                fillColor: Colors.transparent,
                suffixIconConstraints: BoxConstraints(
                  maxHeight: DeviceUtils.getScaledSize(context, 0.025) * 2,
                ),
                suffixIcon: Container(
                  padding: EdgeInsets.only(
                      right: DeviceUtils.getScaledSize(context, 0.025)),
                  child: Icon(
                    Icons.home,
                    size: DeviceUtils.getScaledSize(context, 0.045),
                    color: ColorResources.PRIMARY,
                  ),
                ),
              ),
            );
          }),
    );
  }

  ///
  /// button change
  ///
  Widget _changeBtnWidget(
      BuildContext context, AddressController addressController) {
    return GestureDetector(
      onTap: () {
        addressController.changeAddress();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledSize(context, 0.045)),
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
            ],
          ),
        ),
        child: const Text(
          "Thay đổi",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.WHITE,
      appBar: CustomAppBar().customAppBar(title: "Địa chỉ"),
      body: GetBuilder<AddressController>(
          init: AddressController(),
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: DeviceUtils.getScaledSize(context, 0.04),
                    horizontal: DeviceUtils.getScaledSize(context, 0.02)),
                margin: EdgeInsets.symmetric(
                    vertical: DeviceUtils.getScaledSize(context, 0.04),
                    horizontal: DeviceUtils.getScaledSize(context, 0.05)),
                decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    DropDownButton1(
                        hint: "Chọn tỉnh/thành phố",
                        value: controller.province,
                        onChanged: controller.setSelectedProvince,
                        data: controller.provinceList),
                    DropDownButton1(
                        hint: "Chọn quận/huyện",
                        value: controller.district,
                        onChanged: controller.setSelectedDistrict,
                        data: controller.districtList),
                    _inputWidget(context,
                        hint: "Nhập địa chỉ",
                        textController: controller.addressTextController),
                    _changeBtnWidget(context, controller),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
