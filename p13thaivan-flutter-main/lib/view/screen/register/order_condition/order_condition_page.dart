// ignore_for_file: unnecessary_null_checks, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';

// dimensions
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

import 'order_condition_controller.dart';

class OrderConditionPage extends GetView<OrderConditionController> {
  final UserModel user;
  final bool? isRegister;
  final bool? isCondition;
  OrderModel? orderModel;

  OrderConditionPage(
      {Key? key,
      required this.user,
      required this.isRegister,
      required this.isCondition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderConditionController>(
      init: OrderConditionController(isCondition: isCondition),
      builder: (OrderConditionController controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              //app bar
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight + 20),
                child: Container(
                  color: Colors.green,
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        Expanded(child: Container()),
                        TabBar(
                          controller: controller.tabController,
                          tabs: const [
                            Tab(
                              icon: Icon(Icons.confirmation_num_outlined),
                              text: 'Kho hàng điều kiện',
                            ),
                            Tab(
                              icon: Icon(Icons.motorcycle_rounded),
                              text: 'Kho hàng viên nén',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //bottom navigator
              bottomNavigationBar: controller.tabIndex == 0
                  ? _bottomDieuKienContainer(context)
                  : _bottomVienNenContainer(context),

              //body
              body: TabBarView(
                children: [
                  // kho hàng điều kiện
                  _tabData(context),

                  // kho hang viên nén
                  _tabData(context)
                ],
              )),
        );
      },
    );
  }

  void _callProductChooseWidget(BuildContext context, int index) {
    Get.defaultDialog(
      title: controller.items[index].title,
      buttonColor: ColorResources.PRIMARY,
      textConfirm: "Xác nhận",
      textCancel: "Huỷ",
      cancelTextColor: ColorResources.PRIMARY,
      confirmTextColor: ColorResources.WHITE,
      onConfirm: () {
        Get.back();
        // controller.addItemToOrder();
        controller.accept(index);
        controller.countTotal(controller.items[index].amount);
      },
      content: Container(
        margin: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledSize(context, 0.025),
            vertical: DeviceUtils.getScaledSize(context, 0.025)),
        color: ColorResources.WHITE,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dialogBorderWidget(context, index),
                SizedBox(
                  width: DeviceUtils.getScaledSize(
                    context,
                    0.063,
                  ),
                ),
                _quailityWidget(context, index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// tab data widget
  ///
  Widget _tabData(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: DeviceUtils.getScaledSize(context, 0.063),
      ),
      itemCount: controller.items.length,
      itemBuilder: (BuildContext context, index) {
        return Container(
          margin: EdgeInsets.only(
            top: DeviceUtils.getScaledSize(context, 0.03),
          ),
          child: GestureDetector(
            onTap: () {
              // controller.qualityProduct.value = /;
              _callProductChooseWidget(context, index);
            },

            //list sản phẩm
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledSize(context, 0.04)),
              decoration: BoxDecoration(
                  color: ColorResources.WHITE,

                  //nếu sản phẩm được chọn thì border
                  boxShadow: controller.items[index].isChoose == true
                      ? [
                          BoxShadow(
                            blurRadius: 2,
                            color: ColorResources.PRIMARY.withOpacity(0.3),
                            spreadRadius: 2, // Shadow position
                          )
                        ]
                      : null,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //nếu sản phẩm được chọn thì show cancle button
                  if (controller.items[index].isChoose == true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.cancel(index);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                right:
                                    DeviceUtils.getScaledWidth(context, 0.03)),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorResources.WHITE,
                            ),
                            child: Icon(
                              Icons.close_outlined,
                              size: DeviceUtils.getScaledHeight(context, 0.023),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    const SizedBox.shrink(),

                  _productWidget(context, index),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  /// product widget
  ///
  Widget _productWidget(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceUtils.getScaledSize(context, 0.038),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // hình ảnh sản phẩm

          Container(
            height: DeviceUtils.getScaledSize(context, 0.343),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: FadeInImage.assetNetwork(
              placeholder: Images.placeholder,
              image: controller.items[index].url.toString(),
              fit: BoxFit.cover,
              imageErrorBuilder: (c, o, s) => Image.asset(
                Images.placeholder,
                width: double.infinity,
              ),
            ),
          ),

          SizedBox(height: DeviceUtils.getScaledHeight(context, 0.01)),

          //tên sản phẩm
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, 0.068),
            child: Text(
              controller.items[index].title.toString(),
              maxLines: 3,
              style: Dimensions.fontSizeStyle14w600(),
            ),
          ),

          //giá tiền
          Text(
            PriceConverter.convertPrice(
              context,
              controller.items[index].amount.toDouble(),
            ),
          ),
          //số lượng đã chọn
          if (controller.items[index].isChoose == true)
            Text(
              "Đang chọn: ${controller.items[index].quality}",
              style: Dimensions.fontSizeStyle14()
                  .copyWith(color: ColorResources.RED),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  ///
  /// Choose quaility widget
  ///
  Widget _quailityWidget(BuildContext context, int index) {
    if (controller.items[index].isChoose == false) {
      controller.qualityProduct = 1.obs;
    } else {
      controller.qualityProduct = controller.items[index].quality.obs;
    }
    // chọn số lượng sản phẩm
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Text(
            PriceConverter.convertPrice(
                context,
                (controller.items[index].amount *
                        controller.qualityProduct.value)
                    .toDouble()),
            style: titilliumSemiBold.copyWith(color: Colors.grey, fontSize: 18),
          ),
        ),

        SizedBox(
          height: DeviceUtils.getScaledSize(context, 0.02),
        ),

        //button quanlity
        Obx(() => Row(
              children: [
                //decrementQuality
                _iconsquality(
                  context,
                  onTap: () {
                    controller.decrementQuality();
                  },
                  icon: Icon(Icons.remove,
                      color: controller.qualityProduct.value > 1
                          ? ColorResources.PRIMARY
                          : ColorResources.GREY),
                  color: controller.qualityProduct.value > 1
                      ? ColorResources.PRIMARY
                      : ColorResources.GREY,
                ),

                //quanlity
                _iconsquality(
                  context,
                  text: controller.qualityProduct.value.toString(),
                ),

                //incrementQuality
                _iconsquality(
                  context,
                  onTap: () {
                    controller.incrementQuality();
                  },
                  icon: const Icon(
                    Icons.add_outlined,
                    color: ColorResources.PRIMARY,
                  ),
                ),
              ],
            )),
      ],
    );
  }

  ///
  /// Dialog Widget
  ///
  Widget _dialogBorderWidget(BuildContext context, int index) {
    //hình ảnh sản phẩm trong dialog
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Image(
        height: DeviceUtils.getScaledSize(
          context,
          0.25,
        ),
        width: DeviceUtils.getScaledSize(
          context,
          0.25,
        ),
        image: NetworkImage(
          controller.items[index].url.toString(),
        ),
      ),
    );
  }

  ///
  /// bottom payment button kho hang điều kiện
  ///
  Widget _bottomDieuKienContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.04),
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      height: DeviceUtils.getScaledSize(context, 0.60),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2, // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            controller.notificateValidMessage,
            textAlign: TextAlign.justify,
            style: titilliumItalic.copyWith(
                color: ColorResources.PRIMARY, fontSize: 14),
          ),
          Text(
            controller.twoFivePercent,
            style: titilliumSemiBold.copyWith(color: ColorResources.RED),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Tổng tiền phải trả là: ${PriceConverter.convertPrice(context, controller.sum * (controller.tabIndex==0?(.75):(.81)))}",
                style: titilliumBold.copyWith(fontSize: 16),
              ),
              SizedBox(width: DeviceUtils.getScaledSize(context, 0.015)),
              Text(
                PriceConverter.convertPrice(context, controller.sum.toDouble()),
                style: titilliumBold.copyWith(
                  color: ColorResources.GREY,
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black,
                  decorationStyle: TextDecorationStyle.double,
                ),
              ),
            ],
          ),
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),

          // btn checkout
          GestureDetector(
            onTap: () {
              controller.btnContinue(context, user, isRegister!);
            },
            child: _btnContinueWidget(context),
          ),
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
        ],
      ),
    );
  }

  ///
  /// bottom payment button kho hang viên nén
  ///
  Widget _bottomVienNenContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.04),
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      height: DeviceUtils.getScaledSize(context, 0.47),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2, // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            controller.notificateVienNenValidMessage,
            textAlign: TextAlign.justify,
            style: titilliumItalic.copyWith(
                color: ColorResources.PRIMARY, fontSize: 14),
          ),
          Text(
            controller.twoFivePercentVienNen,
            style: titilliumSemiBold.copyWith(color: ColorResources.RED),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Tổng tiền phải trả là: ${PriceConverter.convertPrice(context, controller.sum * (controller.tabIndex==0?(.75):(.81)))}",
                style: titilliumBold.copyWith(fontSize: 16),
              ),
              SizedBox(width: DeviceUtils.getScaledSize(context, 0.015)),
              Text(
                PriceConverter.convertPrice(context, controller.sum.toDouble()),
                style: titilliumBold.copyWith(
                  color: ColorResources.GREY,
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black,
                  decorationStyle: TextDecorationStyle.double,
                ),
              ),
            ],
          ),
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),

          // btn checkout
          GestureDetector(
            onTap: () {
              controller.btnContinue(context, user, isRegister!);
            },
            child: _btnContinueWidget(context),
          ),
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
        ],
      ),
    );
  }

  ///
  ///icons quality
  ///
  Widget _iconsquality(BuildContext context,
      {VoidCallback? onTap, Icon? icon, String? text, Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.01)),
        height: DeviceUtils.getScaledSize(context, 0.064),
        width: DeviceUtils.getScaledSize(context, 0.064),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color ?? ColorResources.PRIMARY),
        ),
        child: text != null ? Align(child: Text(text)) : icon,
      ),
    );
  }

  ///
  /// _btnContinueWidget
  ///
  Widget _btnContinueWidget(BuildContext context) {
    return Container(
      height: DeviceUtils.getScaledSize(context, 0.12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.green,
          ColorResources.PRIMARY,
          Colors.green,
        ], begin: Alignment(0, -1), end: Alignment(0, 1)),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      alignment: Alignment.center,
      width: double.infinity,
      child: const Text(
        "Tiếp tục",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}

///
/// normalInputWidget
///
Widget normalInputWidget(String? label, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: const Color(0xFFEBEDEF), // set border color
        width: 3.0,
      ), // set border width
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ), // set rounded corner radius
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: label,
        border: InputBorder.none,
      ),
      controller: controller,
    ),
  );
}
