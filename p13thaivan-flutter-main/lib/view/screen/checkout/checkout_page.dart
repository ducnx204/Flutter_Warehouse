import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/checkout/checkout_controller.dart';

class CheckoutPage extends GetView<CheckoutController> {
  ///
  ///row text
  ///
  Widget _rowText(BuildContext context,
      {required String text1, required String text2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1,
            textAlign: TextAlign.center,
            style:
                Dimensions.fontSizeStyle14w600().copyWith(color: Colors.grey)),
        Text(text2,
            textAlign: TextAlign.center,
            style: Dimensions.fontSizeStyle14w600()
                .copyWith(color: ColorResources.BLACK)),
      ],
    );
  }

  ///
  ///divider
  ///
  Expanded buildDivider() {
    return const Expanded(
        child: Divider(
      color: Colors.grey,
      height: 1.5,
    ));
  }

  ///
  ///
  ///
  Widget orDivider(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.05),
          horizontal: DeviceUtils.getScaledSize(context, 0.07)),
      child: Row(
        children: [
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style:
                  const TextStyle(color: ColorResources.PRIMARY, fontSize: 15),
            ),
          ),
          buildDivider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().customAppBar(title: "Thanh toán"),
      backgroundColor: ColorResources.WHITE,
      body: GetBuilder<CheckoutController>(
          init: CheckoutController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: DeviceUtils.getScaledSize(context, 0.05)),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.03),
                        vertical: DeviceUtils.getScaledSize(context, 0.03)),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2, // Shadow position
                          ),
                        ],
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(10)),

                    ///
                    ///
                    ///
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  DeviceUtils.getScaledSize(context, 0.025),
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.025)),
                          width: double.infinity,
                          height: DeviceUtils.getScaledSize(context, 0.125),
                          decoration: const BoxDecoration(
                              color: ColorResources.PRIMARY,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),

                          ///
                          ///bill detail
                          ///
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Chi tiết hoá đơn",
                              style: Dimensions.fontSizeStyle16w600()
                                  .copyWith(color: ColorResources.WHITE),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  DeviceUtils.getScaledSize(context, 0.04),
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.05)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tổng tiền phải trả: ",
                                style: Dimensions.fontSizeStyle16w600(),
                              ),
                              Text(
                                PriceConverter.convertPrice(
                                        context, controller.price.toDouble())
                                    .toString(),
                                style: Dimensions.fontSizeStyle16w600(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.03),
                        vertical: DeviceUtils.getScaledSize(context, 0.03)),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2, // Shadow position
                          ),
                        ],
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    DeviceUtils.getScaledSize(context, 0.025),
                                horizontal:
                                    DeviceUtils.getScaledSize(context, 0.025)),
                            width: double.infinity,
                            height: DeviceUtils.getScaledSize(context, 0.125),
                            decoration: const BoxDecoration(
                                color: ColorResources.PRIMARY,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Thông tin tài khoản",
                                style: Dimensions.fontSizeStyle16w600()
                                    .copyWith(color: ColorResources.WHITE),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.04),
                              vertical:
                                  DeviceUtils.getScaledSize(context, 0.03)),
                          child: DefaultTextStyle(
                            style: Dimensions.fontSizeStyle16().copyWith(
                                decoration: TextDecoration.none,
                                color: ColorResources.BLACK),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _rowText(context,
                                    text1: "Số tài khoản:",
                                    text2: "19 0280 1362 1015"),
                                _rowText(context,
                                    text1: "Tên chủ tài khoản",
                                    text2: "Nguyễn Thị Thảo"),
                                _rowText(context,
                                    text1: "Tên ngân hàng",
                                    text2: "Ngân hàng Techcombank"),
                                _rowText(context,
                                    text1: "Chi nhánh", text2: "Hà Nội"),
                                _rowText(context,
                                    text1: "Nội dung",
                                    text2: "Thanh toán đơn hàng"),

                                //divider
                                orDivider(context, "hoặc"),

                                _rowText(context,
                                    text1: "Số tài khoản:",
                                    text2: "8 8801 0309 1986"),
                                _rowText(context,
                                    text1: "Tên chủ tài khoản",
                                    text2: "Nguyễn Thị Thảo"),
                                _rowText(context,
                                    text1: "Tên ngân hàng",
                                    text2: "Ngân hàng MB bank"),
                                _rowText(context,
                                    text1: "Chi nhánh", text2: "Tây Hà Nội"),
                                _rowText(context,
                                    text1: "Nội dung",
                                    text2: "Thanh toán đơn hàng"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.05),
                        vertical: DeviceUtils.getScaledSize(context, 0.03)),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Tải lên hình ảnh thanh toán",
                              style: Dimensions.fontSizeStyle16w600()
                                  .copyWith(color: ColorResources.BLACK),
                            ),
                            Text(
                              "*",
                              style: Dimensions.fontSizeStyle16w600()
                                  .copyWith(color: ColorResources.RED),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: DeviceUtils.getScaledSize(context, 0.025)),
                        GestureDetector(
                          onTap: () {
                            controller.pickImage();
                          },
                          child: Container(
                            height: DeviceUtils.getScaledSize(context, 0.382),
                            width: DeviceUtils.getScaledSize(context, 0.509),
                            padding: EdgeInsets.symmetric(
                                horizontal: DeviceUtils.getScaledSize(context,
                                    controller.image != null ? 0 : 0.101)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: controller.image != null
                                  ? null
                                  : Border.all(width: 2, color: Colors.grey),
                            ),
                            child: controller.image != null
                                ? Image.file(
                                    controller.image!,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/bill.png",
                                        height: 50,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "Bấm vào đây để tải lên hoá đơn",
                                        textAlign: TextAlign.center,
                                        style: Dimensions.fontSizeStyle14w600()
                                            .copyWith(color: Colors.grey),
                                      )
                                    ],
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),

                  ///
                  ///done btn
                  ///
                  GestureDetector(
                    onTap: () {
                      controller.onClickDoneBtn(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledSize(context, 0.1),
                          vertical: DeviceUtils.getScaledSize(context, 0.07)),
                      alignment: Alignment.center,
                      height: DeviceUtils.getScaledSize(context, 0.12),
                      decoration: BoxDecoration(
                          color: ColorResources.PRIMARY,
                          borderRadius: BorderRadius.circular(12)),
                      child: controller.isLoadingCheckout
                          ? const CircularProgressIndicator()
                          : Text(
                              "Hoàn tất",
                              style: Dimensions.fontSizeStyle16w600()
                                  .copyWith(color: ColorResources.WHITE),
                            ),
                    ),
                  ),
                  SizedBox(height: DeviceUtils.getScaledSize(context, 0.15)),
                ],
              ),
            );
          }),
    );
  }
}
