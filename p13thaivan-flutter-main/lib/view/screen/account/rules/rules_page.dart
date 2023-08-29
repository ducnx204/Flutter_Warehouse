import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/custom_appbar.dart';

class RulesPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.WHITE,
      appBar: CustomAppBar().customAppBar(title: "Điều khoản"),
      body: Padding(
        padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.07)),
        child: Column(
          children: [
            Image.asset("assets/images/device.png"),
            Padding(
              padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.05)),
              child: Text(
                "THIẾT BỊ",
                style: Dimensions.fontSizeStyle20w600(),
              ),
            ),
            Text(
              "Bất kỳ thiết bị, hệ thống hoặc tiện ích nào, do Công ty hoặc các nhà thầu phụ của Công ty cung cấp có thể được sử dụng trực tiếp hoặc gián tiếp trong việc cung cấp Dịch vụ, và không phải là đối tượng của một thỏa thuận riêng giữa các Bên theo đó quyền sở hữu được chuyển sang Khách hàng.",
              textAlign: TextAlign.center,
              style: Dimensions.fontSizeStyle16().copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
