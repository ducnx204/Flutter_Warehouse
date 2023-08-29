import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/di_container.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController? _animationController;

  @override
  void onInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animationController!.forward().whenComplete(() async {
      final bool? isFirst = await sl.get<SharedPreferenceHelper>().isFirst;
      final bool? isLogin = await sl.get<SharedPreferenceHelper>().isLogin;

      // is first time
      if (isFirst == null) {
        Get.offNamed(AppRoutes.INTRO);
      } else {
        // check if is login
        if (isLogin != null && isLogin) {
          Get.offNamed(AppRoutes.DASHBOARD);
        } else {
          // is not login
          Get.offNamed(AppRoutes.LOGIN);
        }
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    print('on onClose');
    _animationController!.dispose();
  }
}
