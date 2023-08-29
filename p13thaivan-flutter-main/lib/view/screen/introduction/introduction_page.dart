import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/introduction/introduction_controller.dart';

class IntroductionPage extends GetView<IntroductionController> {
  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset("assets/images/$assetName", width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return GetBuilder<IntroductionController>(
        init: IntroductionController(),
        builder: (IntroductionController value) {
          return IntroductionScreen(
            key: controller.introKey,
            globalBackgroundColor: Colors.white,

            pages: [
              PageViewModel(
                title: "Bảo vệ môi trường",
                body:
                    "Cùng nhau lan tỏa lợi ích về tiết kiệm tài chính và bảo vệ môi trường đến toàn cộng đồng.",
                image: _buildImage("img1.jpg"),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Sản phẩm xanh",
                body:
                    "Mang tới những sản phẩm tốt, thân thiện và bảo vệ môi trường xanh sạch tới cộng đồng (như viên nén tiết kiệm và bảo vệ môi trường Yamamoto…).",
                image: _buildImage("img2.jpg"),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "YTP Mang tới lợi ích và sự hỗ trợ tài chính",
                bodyWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Cộng đồng bảo vệ môi trường xanh", style: bodyStyle),
                  ],
                ),
                decoration: pageDecoration.copyWith(
                  bodyFlex: 2,
                  imageFlex: 4,
                  bodyAlignment: Alignment.bottomCenter,
                  imageAlignment: Alignment.topCenter,
                ),
                image: _buildImage("img3.jpg"),
                reverse: true,
              ),
            ],
            onDone: () => controller.onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            //rtl: true, // Display as right-to-left
            skip: const Text('Bỏ qua',
                style: TextStyle(color: ColorResources.PRIMARY)),
            next:
                const Icon(Icons.arrow_forward, color: ColorResources.PRIMARY),
            done: const Text('Tiếp tục',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorResources.PRIMARY)),
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: kIsWeb
                ? const EdgeInsets.all(12.0)
                : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: ColorResources.PRIMARY,
              activeSize: Size(22.0, 10.0),
              activeColor: ColorResources.PRIMARY,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          );
        });
  }
}
