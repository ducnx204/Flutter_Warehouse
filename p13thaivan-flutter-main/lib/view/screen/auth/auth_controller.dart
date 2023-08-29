import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxInt counter = 1.obs;

  void increaseCounter() {
    counter.value += 12;
    // Get.to(PostsPage());
    Get.snackbar(
      "Hey i'm a Get SnackBar!", // title
      "It's unbelievable! I'm using SnackBar without context!", // message
      icon: const Icon(Icons.alarm),
      shouldIconPulse: true,
      isDismissible: true,
      duration: const Duration(seconds: 3),
    );
    // Get.offNamed(AppRoutes.POSTPAGE);
  }
}
