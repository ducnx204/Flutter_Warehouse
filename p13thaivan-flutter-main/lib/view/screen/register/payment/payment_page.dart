import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/product_condition_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/register/payment/payment_controller.dart';

class PaymentPage extends GetView<PaymentController> {
  final UserModel user;
  final bool isRegister;
  // final OrderModel order;
  final List<ProductConditionModel> items;

  const PaymentPage(
      {Key? key,
      required this.user,
      required this.isRegister,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      init: PaymentController(),
      builder: (PaymentController value) {
        return Scaffold(
          //app bar
          appBar: CustomAppBar().customAppBar(title: "Thanh toán"),

          backgroundColor: ColorResources.WHITE,

          //body
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: DeviceUtils.getScaledSize(context, 0.05)),

                //chi tiết hoá đơn
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: DeviceUtils.getScaledSize(context, 0.03),
                    vertical: DeviceUtils.getScaledSize(context, 0.03),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2, // Shadow position
                      ),
                    ],
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: DeviceUtils.getScaledSize(context, 0.025),
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
                            "Chi tiết hoá đơn",
                            style: Dimensions.fontSizeStyle16w600()
                                .copyWith(color: ColorResources.WHITE),
                          ),
                        ),
                      ),
                      _productListWidget(context),

                      //tổng tiền
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledSize(
                            context,
                            0.05,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tổng tiền phải trả: ",
                              style: Dimensions.fontSizeStyle16w600(),
                            ),
                            Text(
                              PriceConverter.convertPrice(context,
                                  controller.sumCalculator(items) * 1.0),
                              style: Dimensions.fontSizeStyle16w600(),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: DeviceUtils.getScaledSize(
                          context,
                          0.027,
                        ),
                      )
                    ],
                  ),
                ),

                //thông tin tài khoản
                _infoAccountWidget(context),

                //dia chi nhan hang
                _address(context),

                //tải lên hình ảnh thanh toán
                _pickImageWidget(context),

                //done button
                _btnDone(context),
                SizedBox(
                  height: DeviceUtils.getScaledSize(
                    context,
                    0.15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  ///addres
  ///
  Widget _address(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.025)),
      child: Column(
        children: [
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.03)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: DeviceUtils.getScaledSize(context, 0.025)),
              Text(
                "Vui lòng nhập địa chỉ nhận hàng",
                style: Dimensions.fontSizeStyle16w600().copyWith(
                  color: ColorResources.BLACK,
                ),
              ),
              Text(
                "*",
                style: Dimensions.fontSizeStyle16w600().copyWith(
                  color: ColorResources.RED,
                ),
              ),
            ],
          ),
          DropDownButton1(
              hint: "Chọn tỉnh/thành phố",
              value: controller.province,
              onChanged: controller.setSelectedProvince,
              data: controller.provinceList),
          DropDownButton1(
              hint: "Chọn quận/huyện",
              value: controller.district,
              onChanged: controller.setSelectedDistrict,
              data: controller.districtList),
          _inputWidget(context,
              hint: "Nhập địa chỉ",
              textController: controller.addressTextController),
        ],
      ),
    );
  }

  ///
  /// input Widget
  ///
  Widget _inputWidget(BuildContext context,
      {required TextEditingController textController, required String hint}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      child: GetBuilder<PaymentController>(
          init: PaymentController(),
          builder: (controller) {
            return TextField(
              textInputAction: TextInputAction.done,
              textAlignVertical: TextAlignVertical.center,
              controller: textController,
              cursorColor: ColorResources.PRIMARY,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: DeviceUtils.getScaledSize(context, 0.025),
                    vertical: DeviceUtils.getScaledSize(context, 0.038)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARY)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ColorResources.GREY)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ColorResources.GREY)),
                hintText: hint,
                filled: true,
                fillColor: Colors.transparent,
                suffixIconConstraints: BoxConstraints(
                  maxHeight: DeviceUtils.getScaledSize(context, 0.025) * 2,
                ),
                suffixIcon: Container(
                  padding: EdgeInsets.only(
                      right: DeviceUtils.getScaledSize(context, 0.025)),
                  child: Icon(
                    Icons.home,
                    size: DeviceUtils.getScaledSize(context, 0.045),
                    color: ColorResources.PRIMARY,
                  ),
                ),
              ),
            );
          }),
    );
  }

  ///
  /// product list widget
  ///
  Widget _productListWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.05),
          vertical: DeviceUtils.getScaledSize(context, 0.02)),

      //list sản phẩm đã chọn
      child: Column(
        children: List.generate(
          items.length,
          (index) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //hình ảnh sản phẩm
                  _productImage(context, index),

                  //giá tiền
                  _priceWidget(context, index),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: DeviceUtils.getScaledSize(context, 0.01)),
                child: const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// price widget
  ///
  Widget _priceWidget(BuildContext context, int index) {
    return Flexible(
      flex: 3,
      child: Text(
        PriceConverter.convertPrice(context, items[index].amount.toDouble()),
        style: titilliumSemiBold.copyWith(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  ///
  /// product image
  ///
  Widget _productImage(BuildContext context, int index) {
    return Flexible(
      flex: 6,
      child: Row(
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                width: 70,
                height: 70,
                image: items[index].url,
                fit: BoxFit.cover,
                imageErrorBuilder: (c, o, s) => Image.asset(
                  Images.placeholder,
                  width: 70,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //tên sản phẩm
                Text(
                  items[index].title,
                  maxLines: 3,
                  style: titilliumSemiBold.copyWith(fontSize: 14),
                ),

                //số lượng đã chọn
                Text(
                  "x${items[index].quality.toString()}",
                  style: titilliumSemiBold.copyWith(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
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

  ///
  /// info account widget
  ///
  Widget _infoAccountWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.03),
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 2,
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2, // Shadow position
        ),
      ], color: ColorResources.WHITE, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledSize(context, 0.025),
                  horizontal: DeviceUtils.getScaledSize(context, 0.025)),
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
                horizontal: DeviceUtils.getScaledSize(context, 0.04),
                vertical: DeviceUtils.getScaledSize(context, 0.03)),
            child: DefaultTextStyle(
              style: Dimensions.fontSizeStyle16().copyWith(
                  decoration: TextDecoration.none, color: ColorResources.BLACK),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rowText(context,
                      text1: "Số tài khoản:", text2: "19 0280 1362 1015"),
                  _rowText(context,
                      text1: "Tên chủ tài khoản", text2: "Nguyễn Thị Thảo"),
                  _rowText(context,
                      text1: "Tên ngân hàng", text2: "Ngân hàng Techcombank"),
                  _rowText(context, text1: "Chi nhánh", text2: "Hà Nội"),
                  _rowText(context,
                      text1: "Nội dung",
                      text2: "Thanh toán đơn hàng điều kiện"),

                  //divider
                  orDivider(context, "hoặc"),

                  _rowText(context,
                      text1: "Số tài khoản:", text2: "8 8801 0309 1986"),
                  _rowText(context,
                      text1: "Tên chủ tài khoản", text2: "Nguyễn Thị Thảo"),
                  _rowText(context,
                      text1: "Tên ngân hàng", text2: "Ngân hàng MB bank"),
                  _rowText(context, text1: "Chi nhánh", text2: "Tây Hà Nội"),
                  _rowText(context,
                      text1: "Nội dung",
                      text2: "Thanh toán đơn hàng điều kiện"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// pick image widget
  ///
  Widget _pickImageWidget(BuildContext context) {
    return Padding(
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
                style: Dimensions.fontSizeStyle16w600().copyWith(
                  color: ColorResources.BLACK,
                ),
              ),
              Text(
                "*",
                style: Dimensions.fontSizeStyle16w600().copyWith(
                  color: ColorResources.RED,
                ),
              ),
            ],
          ),

          SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),

          //hình ảnh thanh toán
          _imagePaymentWidget(context),
        ],
      ),
    );
  }

  ///
  /// image payment widget
  ///
  Widget _imagePaymentWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.pickImage();
      },
      child: Container(
        height: DeviceUtils.getScaledSize(context, 0.382),
        width: DeviceUtils.getScaledSize(context, 0.509),
        padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledSize(
                context, controller.image != null ? 0 : 0.101)),
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
    );
  }

  ///
  /// done button
  ///
  Widget _btnDone(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onBtnFinishTap(context, user, isRegister, items);
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
        child: Text(
          "Hoàn tất",
          style: Dimensions.fontSizeStyle16w600()
              .copyWith(color: ColorResources.WHITE),
        ),
      ),
    );
  }

  ///
  /// row text
  ///
  Widget _rowText(
    BuildContext context, {
    required String text1,
    required String text2,
  }) {
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
}
