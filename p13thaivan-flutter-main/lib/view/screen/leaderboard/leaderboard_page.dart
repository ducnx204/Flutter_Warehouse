import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'leaderboard_controller.dart';

class LeaderBoardPage extends GetView<LeaderBoardController> {
  @override
  Widget build(BuildContext context) {
    const String title = "Bảng xếp hạng";

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            title,
            style: TextStyle(
              color: Color(0xFF27272A),
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          shadowColor: const Color(0x3F000000),
        ),
        backgroundColor: ColorResources.WHITE,
        body: GetBuilder<LeaderBoardController>(
            init: LeaderBoardController(),
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return controller.contextList.isEmpty
                  ? const Center(
                      child: Text("Chưa có dữ liệu về bảng xếp hạng!"))
                  : Column(
                      children: [
                        SizedBox(
                            height: DeviceUtils.getScaledSize(context, 0.07)),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.contextList.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.onChartsClick(i);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: DeviceUtils.getScaledSize(
                                              context, 0.035)),
                                      padding: EdgeInsets.all(
                                          DeviceUtils.getScaledSize(
                                              context, 0.025)),
                                      decoration: BoxDecoration(
                                        color: ColorResources.WHITE,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholder:
                                                        Images.placeholder,
                                                    image: controller
                                                        .contextList[i]
                                                        .thumbnail!,
                                                    fit: BoxFit.fill,
                                                    imageErrorBuilder:
                                                        (c, o, s) =>
                                                            Image.asset(
                                                      Images.placeholder,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                              width: DeviceUtils.getScaledSize(
                                                  context, 0.02)),
                                          Container(
                                            height: DeviceUtils.getScaledSize(
                                                context, 0.25),
                                            width: 1,
                                            color: ColorResources.GREY,
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      DeviceUtils.getScaledSize(
                                                          context, 0.025),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        controller
                                                            .contextList[i]
                                                            .name!,
                                                        maxLines: 3,
                                                        style: Dimensions
                                                            .fontSizeStyle18w600()),
                                                    SizedBox(
                                                        height: DeviceUtils
                                                            .getScaledSize(
                                                                context, 0.02)),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Từ ${DateConverter.isoStringToLocalDateFull(controller.contextList[i].beginContext!)}",
                                                            style: Dimensions
                                                                    .fontSizeStyle14w600()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .grey)),
                                                        Text(
                                                            "đến ${DateConverter.isoStringToLocalDateFull(controller.contextList[i].endContext!)}",
                                                            style: Dimensions
                                                                    .fontSizeStyle14w600()
                                                                .copyWith(
                                                                    color: Colors
                                                                        .grey)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: DeviceUtils.getScaledSize(
                                          context, 0.1),
                                    ),
                                    child: const Divider(
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              );
                            }),
                      ],
                    );
            }));
  }
}
