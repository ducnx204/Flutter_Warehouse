import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart'; 

class AuthPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {

    AuthController _controller = Get.find();

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(()=>Text("Counter ${controller.counter.value}")),
              RaisedButton(
                child: Text("Increase"),
                onPressed: () => controller.increaseCounter(),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
