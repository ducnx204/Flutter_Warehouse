import 'package:flutter/material.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/account/order/component/line_painter.dart';

class CustomStepper extends StatelessWidget {
  final String title;
  final Color color;
  final bool isLastItem;
  const CustomStepper(
      {required this.title, required this.color, this.isLastItem = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isLastItem ? 50 : 100,
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: CircleAvatar(backgroundColor: color, radius: 10.0),
              ),
              Text(title,
                  style: titilliumRegular.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600))
            ],
          ),
          if (isLastItem)
            const SizedBox.shrink()
          else
            Padding(
              padding:
                  const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE),
              child: CustomPaint(painter: LineDashedPainter(Colors.grey)),
            ),
        ],
      ),
    );
  }
}
