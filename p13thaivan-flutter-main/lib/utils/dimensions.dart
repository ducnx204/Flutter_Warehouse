import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';

class Dimensions {
  static const double FONT_SIZE_EXTRA_SMALL = 10.0;
  static const double FONT_SIZE_SMALL = 12.0;
  static const double FONT_SIZE_DEFAULT = 14.0;
  static const double FONT_SIZE_LARGE = 16.0;
  static const double FONT_SIZE_EXTRA_LARGE = 18.0;
  static const double FONT_SIZE_OVER_LARGE = 22.0;

  static const double PADDING_SIZE_EXTRA_SMALL = 5.0;
  static const double PADDING_SIZE_SMALL = 10.0;
  static const double PADDING_SIZE_DEFAULT = 15.0;
  static const double PADDING_SIZE_LARGE = 20.0;
  static const double PADDING_SIZE_EXTRA_LARGE = 25.0;

  static const double MARGIN_SIZE_EXTRA_SMALL = 5.0;
  static const double MARGIN_SIZE_SMALL = 10.0;
  static const double MARGIN_SIZE_DEFAULT = 15.0;
  static const double MARGIN_SIZE_LARGE = 20.0;
  static const double MARGIN_SIZE_EXTRA_LARGE = 25.0;

  static const double ICON_SIZE_EXTRA_SMALL = 12.0;
  static const double ICON_SIZE_SMALL = 18.0;
  static const double ICON_SIZE_DEFAULT = 24.0;
  static const double ICON_SIZE_LARGE = 32.0;
  static const double ICON_SIZE_EXTRA_LARGE = 40.0;

  static const double SPACE_WIDTH_SMALL = 5.0;
  static const double SPACE_WIDTH_DEFAULT = 10.0;
  static const double SPACE_WIDTH_FAR = 50.0;

  static const double CATEGORY_WIDTH_DEFAULT = 70.0;

  static const double SPACE_HEIGHT_SMALL = 5.0;
  static const double SPACE_HEIGHT_DEFAULT = 10.0;

  static const double SQUARE_CATEGORY_SIZE = 170.0;

  // BORDER RADIUS
  static const double BORDER_RADIUS_EXTRA_SMALL = 5.0;
  static const double BORDER_RADIUS_SMALL = 7.0;
  static const double BORDER_RADIUS_DEFAULT = 10.0;
  static const double BORDER_RADIUS_LARGE = 30.0;
  static const double BORDER_RADIUS_EXTRA_LARGE = 50.0;

  // AVATAR
  static const double AVATAR_SQUARE_SIZE_EXTRA_SMALL = 25;
  static const double AVATAR_SQUARE_SIZE_SMALL = 50;
  static const double AVATAR_SQUARE_SIZE_DEFAULT = 100;
  static const double AVATAR_SQUARE_SIZE_LARGE = 150;
  static const double AVATAR_SQUARE_SIZE_EXTRA_LARGE = 200;

  Widget paddingDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledSize(context, 0.02),
      ),
      child: const Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }

  static TextStyle fontSizeStyle20() {
    return const TextStyle(fontSize: 20);
  }

  static TextStyle fontSizeStyle18() {
    return const TextStyle(fontSize: 18);
  }

  static TextStyle fontSizeStyle16() {
    return const TextStyle(fontSize: 16);
  }

  static TextStyle fontSizeStyle14() {
    return const TextStyle(fontSize: 14);
  }

  static TextStyle fontSizeStyle12() {
    return const TextStyle(fontSize: 12);
  }

  static TextStyle fontSizeStyle20w600() {
    return const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  }

  static TextStyle fontSizeStyle22w600() {
    return const TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  }

  static TextStyle fontSizeStyle18w600() {
    return const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  }

  static TextStyle fontSizeStyle16w600() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  }

  static TextStyle fontSizeStyle14w600() {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  }

  static TextStyle fontSizeStyle12w600() {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  }
}
