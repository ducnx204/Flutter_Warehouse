import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/view/screen/product_detail/product_detail_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/parser.dart';

class ProductSpecification extends StatelessWidget {
  final String productSpecification;
  const ProductSpecification({Key? key, required this.productSpecification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailController = Get.find<ProductDetailController>();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return Container(
      height: productDetailController.isLoadingMore
          ? null
          : DeviceUtils.getScaledHeight(context, 0.4),
      color: ColorResources.WHITE,
      padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.027)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: DeviceUtils.getScaledSize(context, 0.027),
                top: DeviceUtils.getScaledSize(context, 0.02),
                bottom: DeviceUtils.getScaledSize(context, 0.02)),
            child: const Text(
              "Thông tin sản phẩm",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          const Divider(color: Colors.grey),
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.03)),

          //hiển thị thông tin
          if (productSpecification.isEmpty)
            const Center(child: Text('Chưa có mô tả sản phẩm'))
          else
            productDetailController.isLoadingMore
                ? Html(data: CommonHelper().htmlUnescape(productSpecification))
                : Flexible(
                    child: Html(
                        data:
                            CommonHelper().htmlUnescape(productSpecification))),

          SizedBox(height: DeviceUtils.getScaledSize(context, 0.03)),

          //more
          if (productSpecification.isEmpty)
            const SizedBox.shrink()
          else
            GestureDetector(
              onTap: () {
                productDetailController.isLoadingMore
                    ? productDetailController.loadingMore()
                    : productDetailController.loadingLess();
              },
              child: Align(
                child: Column(
                  children: [
                    Text(
                      productDetailController.isLoadingMore
                          ? "Thu gọn"
                          : "Xem thêm",
                      style: const TextStyle(color: ColorResources.PRIMARY),
                    ),
                    Icon(
                      productDetailController.isLoadingMore
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                      color: ColorResources.PRIMARY,
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  ///
  ///  parse Html String
  ///
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}
