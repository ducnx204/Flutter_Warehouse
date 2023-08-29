import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/account/order/component/custom_stepper.dart';
import 'package:template/view/screen/account/order/history/history_controller.dart';

class HistoryPage extends GetView<HistoryController> {
  ///
  ///row text info
  ///
  Row rowText({required String text1, required String text2, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: Dimensions.fontSizeStyle16(),
        ),
        Text(
          text2,
          style: Dimensions.fontSizeStyle16w600()
              .copyWith(color: color ?? ColorResources.BLACK),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return GetBuilder<HistoryController>(
        init: HistoryController(),
        builder: (HistoryController value) {
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: CustomAppBar().customAppBar(title: "Lịch sử"),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                        DeviceUtils.getScaledSize(context, 0.038)),
                    child: Column(
                      children: [
                        rowText(text1: "Trạng thái", text2: "Đã giao hàng"),
                        Dimensions().paddingDivider(context),
                        rowText(
                            text1: "Shipper",
                            text2: "Dương (Công ty IZI Soft)"),
                        Dimensions().paddingDivider(context),
                      ],
                    ),
                  ),
                  Column(
                    children: List.generate(
                        controller.statusShipping.length,
                        (index) => CustomStepper(
                              title:
                                  controller.statusShipping[index].toString(),
                              color: ColorResources.PRIMARY,
                              isLastItem:
                                  index == controller.statusShipping.length - 1,
                            )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
