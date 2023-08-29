import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';

import 'kho_hang_vien_nen_controller.dart';

class KhoHangVienNenPage extends GetView<KhoHangVienNenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe8ffd9),
        appBar: CustomAppBar().customAppBar(title: "Kho hàng viên nén"),
        body: GetBuilder<KhoHangVienNenController>(
            init: KhoHangVienNenController(),
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: controller.productList.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.72,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return GestureDetector(
                              onTap: () => controller.onItemClick(),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorResources.WHITE),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: Images.placeholder,
                                          image: controller
                                              .productList[index].thumbnail!,
                                          fit: BoxFit.fill,
                                          imageErrorBuilder: (c, o, s) =>
                                              Image.asset(
                                            Images.placeholder,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: DeviceUtils.getScaledHeight(
                                            context, 0.01)),
                                    SizedBox(
                                      height: DeviceUtils.getScaledSize(
                                          context, 0.101),
                                      child: Text(
                                        controller.productList[index].name!,
                                        maxLines: 2,
                                        style: Dimensions.fontSizeStyle14w600(),
                                      ),
                                    ),
                                    Text(PriceConverter.convertPrice(
                                        context,
                                        double.parse(controller
                                            .productList[index].prices!)))
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              );
            }));
  }
}
