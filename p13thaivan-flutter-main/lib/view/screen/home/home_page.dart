import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// template
import 'package:template/data/template/categories.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    /**
     * Create home 2 part
     * - part 1: background and avatar and name
     * - part 2: content
     */

    return Scaffold(
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (HomeController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              color: const Color(0xFFF5F5FA),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //avatar background user
                    _avatarBackgroundUser(context),

                    // Đội nhóm
                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
                    _groupWidget(context,
                        DeviceUtils.getScaledSize(context, 0.178), controller),

                    // Danh mục
                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
                    _categoryWidget(context,
                        DeviceUtils.getScaledSize(context, 0.178), controller)
                  ],
                ),
              ),
            );
          }),
    );
  }

  ///
  ///cart btn
  ///
  Widget cartButton(BuildContext context, HomeController controller) {
    return Stack(
      children: [
        Container(
          height: 50,
          width: 50,
          padding:
              const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL + 2),
          decoration: const ShapeDecoration(
              shape: CircleBorder(
                  side: BorderSide(width: 2, color: ColorResources.PRIMARY))),
          child: Image.asset(
            Images.cart,
            color: ColorResources.PRIMARY,
          ),
        ),
        Positioned(
          top: 10,
          right: DeviceUtils.getScaledHeight(context, 0.027),
          child: Container(
            height: DeviceUtils.getScaledHeight(context, 0.02),
            width: DeviceUtils.getScaledWidth(context, 0.04),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorResources.RED,
            ),
            child: Text(
              "1",
              // controller.productFromCartList.length.toString(),
              style: titilliumSemiBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// Group widget
  ///
  Widget _groupWidget(
      BuildContext context, double size, HomeController controller) {
    return CategoryWidget(
      text: "Tạo ID",
      label: 'YTP',
      icon: Icon(Icons.add_outlined,
          color: ColorResources.PRIMARY,
          size: DeviceUtils.getScaledSize(context, 0.045)),
      onPressed: () {
        controller.onRegisterIdClick();
      },
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _danhMucBtn(
                  Container(
                    width: DeviceUtils.getScaledSize(context, 0.22),
                    height: DeviceUtils.getScaledSize(context, 0.22),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size / 3),
                        border:
                            Border.all(width: 3, color: Colors.grey.shade700),
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/dieukien.png",
                            ),
                            fit: BoxFit.fill)),
                  ),
                  'Kho hàng điều kiện', () {
                controller.onBtnKhoHangDieuKienClick();
              }),
              _danhMucBtn(
                  Container(
                    width: DeviceUtils.getScaledSize(context, 0.22),
                    height: DeviceUtils.getScaledSize(context, 0.22),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size / 3),
                        border:
                        Border.all(width: 3, color: Colors.grey.shade700),
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/viennenyamamoto.jpg",
                            ),
                            fit: BoxFit.fill)),
                  ),
                  'Kho hàng viên nén', () {
                controller.onBtnKhoHangVienNenClick();
              }),
              _danhMucBtn(
                  Container(
                    width: DeviceUtils.getScaledSize(context, 0.22),
                    height: DeviceUtils.getScaledSize(context, 0.22),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size / 3),
                        border:
                        Border.all(width: 3, color: Colors.grey.shade700),
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/trogia.png",
                            ),
                            fit: BoxFit.fill)),
                  ),
                  'Kho hàng trợ giá', () {
                controller.onProductVoucherClick();
              }),

            ],
          ),
        ],
      ),
      hasMore: true,
    );
  }

  ///
  /// Category widget
  ///
  Widget _categoryWidget(
      BuildContext context, double size, HomeController controller) {
    return controller.isLoading
        ? const Center(child: CircularProgressIndicator())
        : CategoryWidget(
            text: "Xem thêm",
            label: 'Danh mục',
            onPressed: () {
              controller.onBtnCategoriesClick(0);
            },
            content: controller.categoriesList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.85,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10),
                    itemCount: controller.categoriesList.length <= 6
                        ? controller.categoriesList.length
                        : 6,
                    itemBuilder: (BuildContext context, index) {
                      return _danhMucBtn(
                          Container(
                            width: DeviceUtils.getScaledSize(context, 0.178),
                            height: DeviceUtils.getScaledSize(context, 0.178),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(size / 3),
                              border: Border.all(
                                  width: 3, color: Colors.grey.shade700),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(size / 3),
                              child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder,
                                image:
                                    controller.categoriesList[index].thumbnail!,
                                fit: BoxFit.fill,
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                  Images.placeholder,
                                ),
                              ),
                            ),
                          ),
                          controller.categoriesList[index].name!, () {
                        controller.onBtnCategoriesClick(index);
                      });
                    }),
            hasMore: true,
          );
  }

  ///
  /// nút trong danh muc
  ///
  Widget _danhMucBtn(Widget widget, String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          widget,
          const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
          Container(
            alignment: Alignment.center,
            width: Dimensions.CATEGORY_WIDTH_DEFAULT,
            child: Text(
              label,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF27272A),
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// banner
  ///
  Widget _imgProduct(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: controller.bannerList.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return FadeInImage.assetNetwork(
          placeholder: Images.placeholder,
          width: MediaQuery.of(context).size.width,
          image: controller.bannerList[itemIndex].imageUrl!,
          fit: BoxFit.cover,
          imageErrorBuilder: (c, o, s) => Image.asset(
            Images.placeholder,
            width: MediaQuery.of(context).size.width * .25,
          ),
        );
      },
      options: CarouselOptions(
        height: DeviceUtils.getScaledHeight(context, 0.35),
        autoPlay: true,
        viewportFraction: 1,
      ),
    );
  }

  ///
  /// avatar background user
  ///
  Widget _avatarBackgroundUser(BuildContext context) {
    // get width and height
    final double width = context.mediaQuerySize.width;
    // final double height = context.mediaQuerySize.height;

    // basic font size
    const double _moneyTextSize = Dimensions.FONT_SIZE_OVER_LARGE;
    const double _labelTextSize = Dimensions.FONT_SIZE_DEFAULT;

    // basic font weight
    const FontWeight _moneyFontWeight = FontWeight.bold;
    const FontWeight _labelFontWeight = FontWeight.normal;

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          color: Colors.white,
          height: DeviceUtils.getScaledSize(context, 1.17),
          child: Stack(
            children: [
              // background
              Stack(
                children: [
                  //banner
                  _imgProduct(context),

                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: width,
                      height: DeviceUtils.getScaledSize(context, 0.5347),
                      margin: EdgeInsets.only(
                          top: DeviceUtils.getScaledSize(context, 0.127)),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Color(0xff333333)],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: DeviceUtils.getScaledSize(context, 0.127),
                child: Stack(
                  children: [
                    // basic information statistic
                    Column(
                      children: [
                        SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.05),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width / 2,
                              child: Column(
                                children: [
                                  Text(
                                    PriceConverter.convertPrice(
                                        context,
                                        controller.staticUserResponse
                                            .doanhSoDoiNhom!),
                                    style: const TextStyle(
                                      fontSize: _moneyTextSize,
                                      fontWeight: _moneyFontWeight,
                                    ),
                                  ),
                                  const Text(
                                    "Doanh số đội nhóm",
                                    style: TextStyle(
                                      fontSize: _labelTextSize,
                                      fontWeight: _labelFontWeight,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width / 2,
                              child: Column(
                                children: [
                                  Text(
                                    PriceConverter.convertPrice(
                                        context,
                                        controller
                                            .staticUserResponse.doanSoCaNhan!),
                                    style: const TextStyle(
                                      fontSize: _moneyTextSize,
                                      fontWeight: _moneyFontWeight,
                                    ),
                                  ),
                                  const Text(
                                    "Doanh số cá nhân",
                                    style: TextStyle(
                                      fontSize: _labelTextSize,
                                      fontWeight: _labelFontWeight,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: DeviceUtils.getScaledSize(context, 0.05)),
                        Row(
                          children: [
                            SizedBox(
                              width: width / 2,
                              child: Column(
                                children: [
                                  Text(
                                    controller.staticUserResponse.soLuongId
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: _moneyTextSize,
                                      fontWeight: _moneyFontWeight,
                                    ),
                                  ),
                                  const Text(
                                    "Số lượng ID",
                                    style: TextStyle(
                                      fontSize: _labelTextSize,
                                      fontWeight: _labelFontWeight,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width / 2,
                              child: Column(
                                children: [
                                  Text(
                                    controller.staticUserResponse.soLuongDonHang
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: _moneyTextSize,
                                      fontWeight: _moneyFontWeight,
                                    ),
                                  ),
                                  const Text(
                                    "Số lượng đơn hàng",
                                    style: TextStyle(
                                      fontSize: _labelTextSize,
                                      fontWeight: _labelFontWeight,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),

              Positioned(
                bottom: DeviceUtils.getScaledSize(context, 0.483),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(),
                      margin: EdgeInsets.only(
                        left: DeviceUtils.getScaledSize(context, 0.05),
                        // top: 240 - avatarHeight / 2 - 10,
                      ),
                      child: Stack(
                        children: [
                          // avatar
                          _avatarUser(
                            context,
                            DeviceUtils.getScaledSize(context, 0.254),
                            DeviceUtils.getScaledSize(context, 0.254),
                          ),

                          // info of user
                          _infoUser(
                              context,
                              controller.userModel!.fullname.toString(),
                              controller.userModel!.username.toString(),
                              Colors.white,
                              Colors.white,
                              DeviceUtils.getScaledSize(context, 0.254),
                              MediaQuery.of(context).size.width),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  ///
  /// avatar of user declared
  ///
  Widget _avatarUser(BuildContext context, double width, double height) {
    // return
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(width)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: FadeInImage.assetNetwork(
          placeholder: Images.placeholder,
          width: width,
          height: height,
          image: controller.userModel!.avatar.toString(),
          fit: BoxFit.cover,
          imageErrorBuilder: (c, o, s) => Image.asset(
            Images.placeholder,
            width: MediaQuery.of(context).size.width * .25,
          ),
        ),
      ),
    );
  }

  ///
  /// info of info declared
  ///
  Widget _infoUser(
    BuildContext context,
    String userName,
    String ruleName,
    Color userColor,
    Color ruleColor,
    double marginLeft,
    double width,
  ) {
    // @ is prefix rule name
    const String prefixRuleName = "@";

    return Container(
      width: width - 130,
      margin: EdgeInsets.only(left: marginLeft + 20, top: marginLeft / 4 - 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              userName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: DeviceUtils.getScaledSize(context, 0.035),
                fontWeight: FontWeight.bold,
                color: userColor,
              ),
            ),
          ),
          Container(
            // width: width/3,
            alignment: Alignment.centerLeft,
            child: Text(
              prefixRuleName + ruleName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: DeviceUtils.getScaledSize(context, 0.035),
                fontWeight: FontWeight.normal,
                color: ruleColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              controller.onGroupClick();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 35),
              alignment: Alignment.centerRight,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Xem thêm',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.normal,
                        color: ColorResources.PRIMARY,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: Dimensions.FONT_SIZE_DEFAULT,
                      color: ColorResources.PRIMARY,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
