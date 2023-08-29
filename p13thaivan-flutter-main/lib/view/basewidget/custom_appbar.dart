import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';

class CustomAppBar {
  AppBar customAppBar({required String title}) {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios)),
      backgroundColor: ColorResources.WHITE,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(color: ColorResources.BLACK),
      ),
    );
  }
}
