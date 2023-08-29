import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/account/order/order_controller.dart';

class OrderPage extends GetView<OrderController> {
  ///
  ///order widget
  ///
  Widget orderWidget(BuildContext context, OrderController controller,
      {required String status,
      required String imgUrl,
      required String idOrder,
      required String orderDate,
      required String statusPayment}) {
    return Container(
      margin: EdgeInsets.only(
          left: DeviceUtils.getScaledSize(context, 0.03),
          right: DeviceUtils.getScaledSize(context, 0.03),
          bottom: DeviceUtils.getScaledSize(context, 0.02),
          top: DeviceUtils.getScaledSize(context, 0.03)),
      padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.04)),
      decoration: BoxDecoration(
          color: ColorResources.WHITE, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //status order
          Container(
            padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.02)),
            decoration: BoxDecoration(
                color: status == "0"
                    ? Colors.white
                    : controller.statusBackgroundColor[status],
                borderRadius: BorderRadius.circular(16)),
            child: Text(
              controller.statusLabel[status].toString(),
              style: TextStyle(
                color: status == "0"
                    ? Colors.white
                    : controller.statusColor[status],
              ),
            ),
          ),
          const SizedBox(height: 20),
          //product info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  image: imgUrl,
                  width: DeviceUtils.getScaledSize(context, 0.178),
                  height: DeviceUtils.getScaledSize(context, 0.152),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (c, o, s) => Image.asset(
                    Images.placeholder,
                    height: DeviceUtils.getScaledSize(context, 0.152),
                    width: DeviceUtils.getScaledSize(context, 0.178),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ID: $idOrder",
                      maxLines: 2,
                      style: titilliumSemiBold.copyWith(fontSize: 16),
                    ),
                    Text(
                      "Ngày đặt hàng: ${controller.toLocalDate(orderDate)}",
                      style: titilliumSemiBold.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
          Dimensions().paddingDivider(context),

          //payment method
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text("Tình trạng thanh toán"),
                Text(statusPayment,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///
  ///tab all
  ///
  Widget _tabAll(BuildContext context) {
    return ListView.builder(
        itemCount: controller.orderList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.onOrderWidgetClick(indexTabAll: index);
            },
            child: orderWidget(context, controller,
                status: controller.orderList[index].statusOrder.toString(),
                imgUrl: controller.orderList[index].imagePayment.toString(),
                idOrder: controller.orderList[index].id.toString(),
                orderDate: controller.convertDateTime(
                    controller.orderList[index].updatedAt.toString()),
                statusPayment: controller
                    .statusPayment[controller.orderList[index].statusPayment]
                    .toString()),
          );
        });
  }

  ///
  ///tab index
  ///
  Widget _tabIndex(BuildContext context, String index) {
    return GetBuilder<OrderController>(
        init: OrderController(),
        builder: (controller) {
          return ListView.builder(
              itemCount: controller.orderStatusList[int.parse(index)].length,
              itemBuilder: (BuildContext context, int i) {
                return controller.orderStatusList[int.parse(index)].isEmpty
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          controller.onOrderWidgetClick(
                              i: i, index: (int.parse(index) + 1).toString());
                        },
                        child: orderWidget(context, controller,
                            status: (int.parse(index) + 1).toString(),
                            imgUrl: controller
                                .orderStatusList[int.parse(index)][i]
                                .imagePayment
                                .toString(),
                            idOrder: controller
                                .orderStatusList[int.parse(index)][i].id
                                .toString(),
                            orderDate: controller.convertDateTime(controller
                                .orderStatusList[int.parse(index)][i].updatedAt
                                .toString()),
                            statusPayment: controller.statusPayment[controller
                                    .orderStatusList[int.parse(index)][i]
                                    .statusPayment]
                                .toString()),
                      );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        init: OrderController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return DefaultTabController(
            initialIndex: controller.indexTab,
            length: 6,
            child: Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios)),
                elevation: 1,
                backgroundColor: ColorResources.WHITE,
                iconTheme: const IconThemeData(color: Colors.black),
                title: const Text(
                  "Đơn hàng của tôi",
                  style: TextStyle(color: ColorResources.BLACK),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  // onTap: controller.seletecTabfromAccount,
                  indicatorColor: ColorResources.PRIMARY,
                  labelColor: ColorResources.PRIMARY,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    const Tab(text: "Tất cả"),
                    ...List.generate(
                      controller.statusLabel.keys.length,
                      (index) => Tab(
                          text: controller.statusLabel.values.toList()[index]),
                    )
                  ],
                ),
              ),
              body: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  // tab all
                  _tabAll(context),

                  ...List.generate(controller.statusLabel.keys.length,
                      (index) => _tabIndex(context, (index).toString())),
                ],
              ),
            ),
          );
        });
  }
}
