import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class PostsController extends GetxController {
  // List<Region> regionsList = [];
  bool isLoading = true;

  @override
  void onInit() {
    // RegionProvider().getRegions(onSuccess: (regions) {
    //   isLoading = false;
    //   regionsList.clear();
    //   regionsList.addAll(regions);
    //   update();
    // }, onError: (error) {
    //   isLoading = false;
    //   Get.snackbar(
    //     "Hey i'm a Get SnackBar!", // title
    //     error.toString(), // message
    //     icon: const Icon(Icons.error_outline),
    //     shouldIconPulse: true,
    //     isDismissible: true,
    //     duration: const Duration(seconds: 3),
    //   );
    //   print(error);
    //   update();
    // });
    super.onInit();
  }
}
