import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images.dart';

import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorResources.PRIMARY,
        child: Center(child: Image.asset(Images.logo_image)),
      ),
    );
  }
}
