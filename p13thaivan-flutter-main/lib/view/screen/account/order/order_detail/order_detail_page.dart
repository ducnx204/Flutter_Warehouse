import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/account/order/component/custom_stepper.dart';
import 'package:template/view/screen/account/order/order_controller.dart';
import 'package:template/view/screen/account/order/order_detail/order_detail_controller.dart';

class OrderDetailPage extends GetView<OrderDetailController> {
  ///
  ///container box
  ///
  Container _containerBox(BuildContext context, {required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.017)),
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.04),
          horizontal: DeviceUtils.getScaledSize(context, 0.05)),
      decoration: BoxDecoration(
          color: ColorResources.WHITE, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

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

  ///
  ///thong tin chung
  ///
  Widget _thongTinChung(
      BuildContext context, OrderDetailController controller) {
    return _containerBox(
      context,
      child: Column(
        children: [
          rowText(text1: "ID", text2: controller.orderId.toString()),
          Dimensions().paddingDivider(context),
          rowText(
              text1: "Ngày đặt hàng",
              text2: controller.toLocalDate(controller.orderTime)),
          Dimensions().paddingDivider(context),
          rowText(
              text1: "Trạng thái",
              text2: controller.statusLabel[controller.orderModel.statusOrder]
                  .toString()),
        ],
      ),
    );
  }

  ///
  ///lich su
  ///
  Widget _lichSu(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: Text(
                "Lịch sử",
                style: Dimensions.fontSizeStyle18w600(),
              ),
            ),
            GestureDetector(
              onTap: () {
                // controller.onHistoryClick();
              },
              child: const Text("Chi tiết",
                  style: TextStyle(
                    color: ColorResources.LIGHT_SKY_BLUE,
                  )),
            ),
            SizedBox(width: DeviceUtils.getScaledSize(context, 0.01)),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorResources.LIGHT_SKY_BLUE,
              size: DeviceUtils.getScaledSize(context, 0.035),
            ),
          ],
        ),
        _containerBox(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Giao hàng nhanh"),
              Dimensions().paddingDivider(context),
              const CustomStepper(
                  title: "Đã giao hàng\n19:27 17/09/2021",
                  color: ColorResources.PRIMARY),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///shipping widget
  ///
  Row _shippingWidget(BuildContext context,
      {Image? image,
      Icon? icon,
      required String text1,
      required String text2,
      String? text3}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null)
          Container(
              height: DeviceUtils.getScaledSize(context, 0.063),
              width: DeviceUtils.getScaledSize(context, 0.063),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: image)
        else
          icon!,
        SizedBox(width: DeviceUtils.getScaledSize(context, 0.02)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: Dimensions.fontSizeStyle16(),
              ),
              Text(text2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Dimensions.fontSizeStyle16w600()),
              if (text3 == null)
                const SizedBox.shrink()
              else
                Text(text3,
                    style: Dimensions.fontSizeStyle16()
                        .copyWith(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///shipping
  ///
  Widget _shipping(BuildContext context, OrderDetailController controller) {
    if (controller.isLoadingAddress) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return _containerBox(
      context,
      child: Column(
        children: [
          _shippingWidget(context,
              icon: const Icon(
                Icons.location_on_outlined,
                color: ColorResources.PRIMARY,
              ),
              text1: "Địa chỉ ship",
              text2: "${controller.district}, ${controller.province}"),
          Dimensions().paddingDivider(context),
          _shippingWidget(context,
              image: Image.asset("assets/images/logo.png"),
              text1: "Dịch vụ shipping",
              text2: "Tên dịch vụ",
              text3: "Trong ngày 2h - 3h"),
        ],
      ),
    );
  }

  ///
  ///product info
  ///
  Widget _productInfo(BuildContext context, OrderDetailController controller) {
    return _containerBox(context,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.orderItemList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            image: controller
                                .orderItemList[index].idProduct!.thumbnail
                                .toString(),
                            height: DeviceUtils.getScaledSize(context, 0.178),
                            width: DeviceUtils.getScaledSize(context, 0.178),
                            fit: BoxFit.cover,
                            imageErrorBuilder: (c, o, s) => Image.asset(
                              Images.placeholder,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.orderItemList[index].idProduct!.name
                                  .toString(),
                              maxLines: 2,
                              style: titilliumSemiBold.copyWith(fontSize: 16),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    PriceConverter.convertPrice(
                                        context,
                                        double.parse(controller
                                            .orderItemList[index]
                                            .idProduct!
                                            .prices!)),
                                    style: titilliumSemiBold.copyWith(
                                        color: Colors.grey),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "x${controller.orderItemList[index].quantity}",
                                    style: titilliumSemiBold.copyWith(
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  if (index == 2)
                    const SizedBox.shrink()
                  else
                    Dimensions().paddingDivider(context),
                ],
              );
            }));
  }

  ///
  ///payment detail
  ///
  Widget _paymentDetail(
      BuildContext context, OrderDetailController controller) {
    return _containerBox(context,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: DeviceUtils.getScaledSize(context, 0.015)),
          child: Column(
            children: [
              rowText(
                  text1: "Giá tiền",
                  text2: PriceConverter.convertPrice(
                      context, controller.price!.toDouble())),
              SizedBox(height: DeviceUtils.getScaledSize(context, 0.015)),
              rowText(text1: "Phí ship", text2: "0 đ"),
              SizedBox(height: DeviceUtils.getScaledSize(context, 0.015)),
              rowText(
                  text1: "Tổng tiền",
                  text2: PriceConverter.convertPrice(
                      context, controller.price!.toDouble())),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar().customAppBar(title: "Order của tôi"),
        body: GetBuilder<OrderDetailController>(
            init: OrderDetailController(),
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DeviceUtils.getScaledSize(context, 0.038)),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.05)),
                      //thong tin chung
                      Text(
                        "Thông tin chung",
                        style: Dimensions.fontSizeStyle18w600(),
                      ),
                      SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.015)),
                      _thongTinChung(context, controller),

                      // SizedBox(height: DeviceUtils.getScaledSize(context, 0.02)),

                      //lich su
                      // _lichSu(context),

                      SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.05)),

                      //shipping
                      _shipping(context, controller),

                      SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.05)),

                      //product info
                      Text("Thông tin sản phẩm",
                          style: Dimensions.fontSizeStyle18w600()),
                      SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.015)),
                      _productInfo(context, controller),

                      //payment detail
                      SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.05)),
                      Text(
                        "Chi tiết thanh toán",
                        style: Dimensions.fontSizeStyle18w600(),
                      ),
                      SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.015)),
                      _paymentDetail(context, controller)
                    ],
                  ),
                ),
              );
            }));
  }
}
