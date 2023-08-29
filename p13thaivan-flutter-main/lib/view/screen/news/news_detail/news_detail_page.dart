import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/news/news_detail/news_detail_controller.dart';
import 'package:template/view/screen/news/news_detail/news_specification.dart';

class NewsDetailPage extends GetView<NewsDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.WHITE,
        appBar: CustomAppBar().customAppBar(title: "Tiêu đề"),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<NewsDetailController>(
                init: NewsDetailController(),
                builder: (controller) {
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: DeviceUtils.getScaledSize(context, 0.04),
                        horizontal: DeviceUtils.getScaledSize(context, 0.04)),
                    child: DefaultTextStyle(
                      style: TextStyle(height: 1.3, color: Colors.grey[600]),
                      child: Column(
                        children: [
                          Container(
                            height: DeviceUtils.getScaledSize(context, 0.7),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder,
                              image: controller.newsModel!.image!,
                              fit: BoxFit.contain,
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                Images.placeholder,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      DeviceUtils.getScaledSize(context, 0.05),
                                  vertical:
                                      DeviceUtils.getScaledSize(context, 0.04)),
                              child: Text(
                                controller.newsModel!.name!,
                                style: Dimensions.fontSizeStyle20w600()
                                    .copyWith(color: ColorResources.BLACK),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    DeviceUtils.getScaledSize(context, 0.04)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 7,
                                      child: Text(
                                        controller.newsModel!.tags!,
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                      )),
                                  Expanded(
                                    flex: 4,
                                    child: Text(controller.timeAgo(controller
                                        .newsModel!.createdAt!
                                        .toString())),
                                  ),
                                ]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    DeviceUtils.getScaledSize(context, 0.2),
                                vertical:
                                    DeviceUtils.getScaledSize(context, 0.03)),
                            child: const Divider(color: ColorResources.GREY),
                          ),

                          ///
                          ///body
                          ///
                          NewsSpecification(
                              newsSpecification: controller.newsModel!.body!),
                        ],
                      ),
                    ),
                  );
                })));
  }
}
