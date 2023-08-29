import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'account_controller.dart';

class AccountPage extends GetView<AccountController> {
  ///
  ///container box
  ///
  Container _containerBox(BuildContext context, {required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.017)),
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.06),
          horizontal: DeviceUtils.getScaledSize(context, 0.05)),
      decoration: BoxDecoration(
          color: ColorResources.WHITE, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  ///
  ///row co 3 item
  ///
  Row _row3(BuildContext context,
      {required String text1, required String text2, VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text1,
            style: Dimensions.fontSizeStyle18w600(),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(text2,
                  style: const TextStyle(
                    color: ColorResources.PRIMARY,
                  )),
              SizedBox(width: DeviceUtils.getScaledSize(context, 0.01)),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorResources.PRIMARY,
                size: DeviceUtils.getScaledSize(context, 0.035),
              ),
            ],
          ),
        )
      ],
    );
  }

  ///
  ///icons method
  ///
  Widget _iconMethod(BuildContext context,
      {required String imgUrl,
      required String text,
      required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            SvgPicture.asset(imgUrl),
            SizedBox(height: DeviceUtils.getScaledSize(context, 0.04)),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Dimensions.fontSizeStyle16(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AccountController>(
            init: AccountController(),
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.038)),
                  child: Align(
                    child: Column(
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  //image
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: DeviceUtils.getScaledSize(
                                            context, 0.02)),
                                    height: DeviceUtils.getScaledSize(
                                        context, 0.183),
                                    width: DeviceUtils.getScaledSize(
                                        context, 0.183),
                                    child: ClipOval(
                                      child: FadeInImage.assetNetwork(
                                          placeholder: Images.placeholder,
                                          image: controller.userModel.avatar
                                              .toString(),
                                          fit: BoxFit.cover,
                                          imageErrorBuilder: (c, o, s) =>
                                              const CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      Images.placeholder))),
                                    ),
                                  ),

                                  //name
                                  Text(
                                    controller.userModel.fullname.toString(),
                                    style: Dimensions.fontSizeStyle16w600(),
                                  ),

                                  SizedBox(
                                      height: DeviceUtils.getScaledSize(
                                          context, 0.02)),
                                ],
                              ),
                              Positioned(
                                right: DeviceUtils.getScaledSize(context, 0.01),
                                bottom:
                                    DeviceUtils.getScaledSize(context, 0.076),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.onEditInfoClick();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: DeviceUtils.getScaledSize(
                                          context, 0.045),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        //ID
                        Text(
                          "@${controller.userModel.username}",
                          style: Dimensions.fontSizeStyle16(),
                        ),

                        SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.04),
                        ),

                        //my order
                        _containerBox(context,
                            child: Column(
                              children: [
                                _row3(context,
                                    text1: "Order của tôi",
                                    text2: "Xem thêm", onTap: () {
                                  controller.onOrderClick(0);
                                }),
                                SizedBox(
                                    height: DeviceUtils.getScaledSize(
                                        context, 0.1)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _iconMethod(context,
                                        imgUrl:
                                            "assets/icon/delivery_truck.svg",
                                        text: "Đã vận chuyển", onTap: () {
                                      controller.onOrderClick(3);
                                    }),
                                    _iconMethod(context,
                                        imgUrl: "assets/icon/wallet.svg",
                                        text: "Đã giao hàng", onTap: () {
                                      controller.onOrderClick(4);
                                    }),
                                    _iconMethod(context,
                                        imgUrl:
                                            "assets/icon/forklift_truck.svg",
                                        text: "Đang xử lý", onTap: () {
                                      controller.onOrderClick(2);
                                    }),
                                  ],
                                ),
                              ],
                            )),

                        //educate
                        GestureDetector(
                          onTap: () {
                            controller.onEducateClick();
                          },
                          child: _containerBox(context,
                              child: _row3(context,
                                  text1: "Đăng ký đào tạo", text2: "Đăng ký")),
                        ),
                        // //cart
                        // GestureDetector(
                        //   onTap: () {
                        //     controller.onCartClick();
                        //   },
                        //   child: _containerBox(context,
                        //       child: _row3(
                        //         context,
                        //         text1: "Giỏ hàng",
                        //         text2: "Chi tiết",
                        //       )),
                        // ),

                        //rules
                        GestureDetector(
                          onTap: () {
                            controller.onRulesClick();
                          },
                          child: _containerBox(context,
                              child: _row3(
                                context,
                                text1: "Điều khoản",
                                text2: "Chi tiết",
                              )),
                        ),

                        //share
                        GestureDetector(
                          onTap: () {
                            Share.share('https://ytp.vn');
                          },
                          child: _containerBox(
                            context,
                            child: _row3(
                              context,
                              text1: "Chia sẻ",
                              text2: "",
                            ),
                          ),
                        ),

                        //password_change
                        GestureDetector(
                          onTap: () {
                            controller.onChangePasswordClick();
                          },
                          child: _containerBox(context,
                              child: _row3(context,
                                  text1: "Đổi mật khẩu", text2: "")),
                        ),

                        //logout
                        GestureDetector(
                          onTap: () {
                            controller.onLogoutClick();
                          },
                          child: _containerBox(
                            context,
                            child: _row3(
                              context,
                              text1: "Đăng xuất",
                              text2: "",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
