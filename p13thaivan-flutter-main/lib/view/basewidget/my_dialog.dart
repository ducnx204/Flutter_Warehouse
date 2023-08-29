import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/view/basewidget/button/custom_button.dart';

class MyDialog extends StatelessWidget {
  final double rotateAngle;
  final IconData icon;
  final String title;
  final String description;
  const MyDialog(
      {this.rotateAngle = 0,
      required this.icon,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.05)),
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            left: 0,
            right: 0,
            top: DeviceUtils.getScaledSize(context, -0.14),
            child: Container(
              height: DeviceUtils.getScaledSize(context, 0.203),
              width: DeviceUtils.getScaledSize(context, 0.203),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: ColorResources.PRIMARY, shape: BoxShape.circle),
              child: Transform.rotate(
                  angle: rotateAngle,
                  child: Icon(icon,
                      size: DeviceUtils.getScaledSize(context, 0.101),
                      color: Colors.white)),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: DeviceUtils.getScaledSize(context, 0.101)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(title,
                  style: robotoBold.copyWith(
                      fontSize: DeviceUtils.getScaledSize(context, 0.04))),
              SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
              Text(description,
                  textAlign: TextAlign.center, style: titilliumRegular),
              SizedBox(height: DeviceUtils.getScaledSize(context, 0.05)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DeviceUtils.getScaledSize(context, 0.05)),
                child: CustomButton(
                    buttonText: "OK", onTap: () => Navigator.pop(context)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
