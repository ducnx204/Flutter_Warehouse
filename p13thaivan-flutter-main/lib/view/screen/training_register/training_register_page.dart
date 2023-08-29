import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/training_register/training_register_controller.dart';

class TrainingRegisterPage extends GetView<TrainingRegisterController> {
  ///
  /// input widget
  ///
  Widget _normalInputWidget(BuildContext context,
      {String? label,
      required TextEditingController textController,
      required TextInputType textInputType}) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      child: TextField(
        textInputAction: TextInputAction.next,
        textAlignVertical: TextAlignVertical.center,
        controller: textController,
        keyboardType: textInputType,
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
  /// _dateTimePickNgaySinh
  ///
  Widget _dateTimePicker(BuildContext context,
      {required String label, required TextEditingController textController}) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          locale: const Locale("vi", "VI"),
          initialDate: DateTime(2021),
          firstDate: DateTime(1920),
          lastDate: DateTime(2200),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData().copyWith(
                primaryColor: ColorResources.PRIMARY,
                accentColor: ColorResources.PRIMARY,
                colorScheme:
                    const ColorScheme.light(primary: ColorResources.PRIMARY),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        ).then((value) =>
            textController.text = DateConverter.estimatedDateM(value!));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledSize(context, 0.03)),
        child: TextField(
          textInputAction: TextInputAction.none,
          textAlignVertical: TextAlignVertical.center,
          controller: textController,
          cursorColor: ColorResources.PRIMARY,
          enabled: false,
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
            suffixIconConstraints: const BoxConstraints(
              maxHeight: Dimensions.PADDING_SIZE_SMALL * 2,
            ),
            suffixIcon: Container(
              padding:
                  const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
              child: const Icon(
                Icons.date_range,
                size: 18,
                color: ColorResources.PRIMARY,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// button đăng ký
  ///
  Widget _buttonRegister(
      BuildContext context, TrainingRegisterController controller) {
    return GestureDetector(
      onTap: () => controller.onClickBtnRegister(context),
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
          "Đăng ký",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar().customAppBar(title: "Đăng ký đào tạo"),
        backgroundColor: ColorResources.WHITE,
        body: GetBuilder<TrainingRegisterController>(
            init: TrainingRegisterController(),
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.04),
                        vertical: DeviceUtils.getScaledSize(context, 0.035)),
                    child: Column(
                      children: [
                        //họ tên người đăng ký
                        _normalInputWidget(context,
                            label: "Họ và tên",
                            textInputType: TextInputType.name,
                            textController: controller.fullnameTexController),

                        //Ngày tháng năm sinh
                        _dateTimePicker(context,
                            label: "Ngày tháng năm sinh",
                            textController: controller.bornTexController),

                        //Địa chỉ nơi ở
                        _normalInputWidget(context,
                            label: "Địa chỉ nơi ở",
                            textInputType: TextInputType.streetAddress,
                            textController: controller.addressTexController),

                        //Số điện thoại
                        _normalInputWidget(context,
                            label: "Số điện thoại",
                            textInputType: TextInputType.phone,
                            textController: controller.phoneTexController),

                        //Chức vụ cộng tác viên
                        _normalInputWidget(context,
                            label: "Chức vụ cộng tác viên",
                            textInputType: TextInputType.text,
                            textController: controller.positionTexController),

                        //Địa điểm
                        _normalInputWidget(context,
                            label: "Địa điểm",
                            textInputType: TextInputType.streetAddress,
                            textController:
                                controller.addressLearningTexController),

                        //Nội dung muốn đào tạo
                        _normalInputWidget(context,
                            label: "Nội dung muốn đào tạo",
                            textInputType: TextInputType.text,
                            textController: controller.contentTexController),

                        //thời gian bắt đầu
                        _dateTimePicker(context,
                            label: "Thời gian bắt đầu",
                            textController:
                                controller.dateStartWorkingTexController),

                        //ngày tháng năm làm đơn
                        _dateTimePicker(context,
                            label: "Ngày tháng năm làm đơn",
                            textController:
                                controller.dateRegistrationTexController),

                        // Đăng ký
                        _buttonRegister(context, controller),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
