import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class CategoryWidget extends GetView {
  CategoryWidget({
    required this.text,
    required this.label,
    required this.content,
    required this.hasMore,
    this.icon,
    this.onPressed,
  });

  String text;
  String label;
  Widget content;
  bool hasMore;
  Icon? icon;
  VoidCallback? onPressed;

  double labelFontSize = Dimensions.FONT_SIZE_EXTRA_LARGE;
  Color labelColor = const Color(0XFF27272A);

  double moreFontSize = Dimensions.FONT_SIZE_LARGE;
  Color moreColor = const Color(0XFF1A94FF);

  double elementFontSize = Dimensions.FONT_SIZE_SMALL;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: width * .60,
                  child: Text(
                    label,
                    style: TextStyle(
                        fontSize: labelFontSize,
                        fontWeight: FontWeight.bold,
                        color: labelColor),
                  ),
                ),
                Container(
                  // width: width * .5,
                  child: (hasMore == true)
                      ? ElevatedButton(
                          style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: onPressed,
                          child: Row(
                            children: [
                              Text(
                                text,
                                style: TextStyle(
                                    fontSize: moreFontSize,
                                    color: ColorResources.PRIMARY),
                              ),
                              icon ??
                                  const Icon(Icons.arrow_forward_ios_outlined,
                                      color: ColorResources.PRIMARY,
                                      size: Dimensions.FONT_SIZE_EXTRA_LARGE)
                            ],
                          ),
                        )
                      : Container(),
                )
              ],
            ),
            Container(padding: const EdgeInsets.all(15), child: content),
          ],
        ));
  }
}
