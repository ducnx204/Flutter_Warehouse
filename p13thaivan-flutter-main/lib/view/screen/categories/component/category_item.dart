import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final bool isSelected;
  const CategoryItem(
      {required this.title, required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledSize(context, 0.254),
      height: DeviceUtils.getScaledSize(context, 0.254),
      decoration: BoxDecoration(
        color: isSelected ? ColorResources.WHITE : null,
      ),
      child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Color((math.Random().nextDouble() * 0xFFE8E8E8).toInt())
                  .withOpacity(1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                ClipRRect(borderRadius: BorderRadius.circular(10), child: icon),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: titilliumSemiBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  color: isSelected ? Colors.grey[600] : ColorResources.BLACK,
                )),
          ),
        ]),
      ),
    );
  }
}
