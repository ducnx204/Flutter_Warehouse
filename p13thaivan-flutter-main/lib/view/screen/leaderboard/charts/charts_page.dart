import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/leaderboard/charts/charts_controller.dart';

class ChartsPage extends GetView<ChartsController> {
  ///
  ///circle avatar
  ///
  Widget _circleAvatar(BuildContext context,
      {required String imgUrl, required int rank}) {
    return Container(
      margin: EdgeInsets.only(top: DeviceUtils.getScaledSize(context, 0.04)),
      height: DeviceUtils.getScaledSize(context, 0.18),
      width: DeviceUtils.getScaledSize(context, 0.18),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 4,
          color: rank == 1
              ? const Color(0xffFFC107)
              : rank == 2
                  ? ColorResources.GREY
                  : rank == 3
                      ? ColorResources.PRIMARY
                      : ColorResources.WHITE,
        ),
      ),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            image: imgUrl,
            fit: BoxFit.cover,
            imageErrorBuilder: (c, o, s) => const CircleAvatar(
                backgroundImage: AssetImage(Images.placeholder))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.WHITE,
        appBar: CustomAppBar().customAppBar(title: "Mục bảng thống kê"),
        body: GetBuilder<ChartsController>(
            init: ChartsController(),
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.04)),

                    //rank
                    SizedBox(
                      height: DeviceUtils.getScaledSize(context, 0.75),
                      child: Stack(
                        children: [
                          Positioned(
                            top: DeviceUtils.getScaledSize(context, 0.38),
                            right: DeviceUtils.getScaledSize(context, 0.19),
                            child: Image.asset(
                              Images.charts,
                              height: DeviceUtils.getScaledSize(context, 0.4),
                            ),
                          ),
                          //2nd
                          Positioned(
                            left: DeviceUtils.getScaledSize(context, 0.127),
                            top: DeviceUtils.getScaledSize(context, 0.127),
                            child: _circleAvatar(context,
                                imgUrl: controller
                                    .personalHonorList[1].idUser!.avatar!,
                                rank: 2),
                          ),

                          Positioned(
                            left: DeviceUtils.getScaledSize(context, 0.05),
                            bottom: DeviceUtils.getScaledSize(context, 0.356),
                            child: Text(
                                controller
                                    .personalHonorList[1].idUser!.fullname!,
                                textAlign: TextAlign.center,
                                style: Dimensions.fontSizeStyle14w600()),
                          ),

                          //1st
                          Positioned(
                            left: DeviceUtils.getScaledSize(context, 0.407),
                            top: DeviceUtils.getScaledSize(context, 0.012),
                            child: Stack(
                              children: [
                                _circleAvatar(context,
                                    imgUrl: controller
                                        .personalHonorList[0].idUser!.avatar!,
                                    rank: 1),
                                Positioned(
                                    right: DeviceUtils.getScaledSize(
                                        context, 0.06),
                                    child: SvgPicture.asset(
                                        "assets/icon/crown.svg")),
                              ],
                            ),
                          ),
                          Positioned(
                            left: DeviceUtils.getScaledSize(context, 0.356),
                            top: DeviceUtils.getScaledSize(context, 0.254),
                            child: Text(
                                controller
                                    .personalHonorList[0].idUser!.fullname!,
                                textAlign: TextAlign.center,
                                style: Dimensions.fontSizeStyle14w600()),
                          ),

                          //3rd
                          Positioned(
                            right: DeviceUtils.getScaledSize(context, 0.127),
                            top: DeviceUtils.getScaledSize(context, 0.127),
                            child: _circleAvatar(context,
                                imgUrl: controller
                                    .personalHonorList[2].idUser!.avatar!,
                                rank: 3),
                          ),
                          Positioned(
                            right: DeviceUtils.getScaledSize(context, 0.089),
                            top: DeviceUtils.getScaledSize(context, 0.356),
                            child: Text(
                                controller
                                    .personalHonorList[2].idUser!.fullname!,
                                textAlign: TextAlign.center,
                                style: Dimensions.fontSizeStyle14w600()),
                          ),
                        ],
                      ),
                    ),

                    ///
                    ///list doanh số
                    ///
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledSize(context, 0.063),
                          vertical: DeviceUtils.getScaledSize(context, 0.025)),
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2, // Shadow position
                          ),
                        ],
                      ),
                      child: Column(children: [
                        SizedBox(
                            height: DeviceUtils.getScaledSize(context, 0.025)),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.personalHonorList.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: DeviceUtils.getScaledSize(
                                            context, 0.03)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${i + 1}",
                                          style:
                                              Dimensions.fontSizeStyle18w600(),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: DeviceUtils
                                                        .getScaledSize(
                                                            context, 0.025)),
                                                height:
                                                    DeviceUtils.getScaledSize(
                                                        context, 0.12),
                                                width:
                                                    DeviceUtils.getScaledSize(
                                                        context, 0.12),
                                                child: ClipOval(
                                                  child: FadeInImage.assetNetwork(
                                                      placeholder:
                                                          Images.placeholder,
                                                      image: controller
                                                          .personalHonorList[i]
                                                          .idUser!
                                                          .avatar!,
                                                      fit: BoxFit.cover,
                                                      imageErrorBuilder: (c, o,
                                                              s) =>
                                                          const CircleAvatar(
                                                              backgroundImage:
                                                                  AssetImage(Images
                                                                      .placeholder))),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(controller
                                                    .personalHonorList[i]
                                                    .idUser!
                                                    .fullname!),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Expanded(
                                        //   flex: 4,
                                        //   child: Align(
                                        //     child: Container(
                                        //       padding: EdgeInsets.all(
                                        //           DeviceUtils.getScaledSize(
                                        //               context, 0.015)),
                                        //       decoration: BoxDecoration(
                                        //           color: ColorResources.GREY,
                                        //           borderRadius:
                                        //               BorderRadius.circular(
                                        //                   16)),
                                        //       child: const Text(
                                        //         "5.000.000đ",
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: DeviceUtils.getScaledSize(
                                          context, 0.01),
                                      horizontal: DeviceUtils.getScaledSize(
                                          context, 0.05),
                                    ),
                                    child: const Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ]),
                    ),
                  ],
                ),
              );
            }));
  }
}
