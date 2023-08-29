import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/group/group_controller.dart';

class GroupPage extends GetView<GroupController> {
  ///
  /// avatar of user declared
  ///
  Widget _avatarUser(BuildContext context, String imageURL) {
    return Container(
      width: DeviceUtils.getScaledSize(context, 0.254),
      height: DeviceUtils.getScaledSize(context, 0.254),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 3, color: ColorResources.WHITE),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: FadeInImage.assetNetwork(
          placeholder: Images.placeholder,
          image: imageURL,
          fit: BoxFit.cover,
          imageErrorBuilder: (c, o, s) => Image.asset(
            Images.placeholder,
            width: MediaQuery.of(context).size.width * .25,
          ),
        ),
      ),
    );
  }

  ///
  /// info of info declared
  ///
  Widget _infoUser(BuildContext context, String userName, String ruleName,
      Color userColor, Color ruleColor, double marginLeft) {
    // user name size is FONT_SIZE_EXTRA_LARGE
    const double userNameSize = Dimensions.FONT_SIZE_EXTRA_LARGE;

    // rule name size is FONT_SIZE_DEFAULT
    const double ruleNameSize = Dimensions.FONT_SIZE_DEFAULT;

    // @ is prefix rule name
    const String prefixRuleName = "@";

    return GetBuilder<GroupController>(
      init: GroupController(),
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(
              vertical: DeviceUtils.getScaledSize(context, 0.012)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  userName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: userNameSize,
                      fontWeight: FontWeight.bold,
                      color: userColor),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  prefixRuleName + ruleName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: ruleNameSize,
                    fontWeight: FontWeight.normal,
                    color: ruleColor,
                  ),
                ),
              ),
              Text(
                  "Doanh số cá nhân: ${PriceConverter.convertPrice(context, controller.staticUserResponse.doanSoCaNhan!)}"),
              Text(
                  "Doanh số đội nhóm: ${PriceConverter.convertPrice(context, controller.staticUserResponse.doanhSoDoiNhom!)}")
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: DeviceUtils.getScaledSize(context, 0.025)),

              //lọc bảng xếp hạng
              child: GestureDetector(
                onTap: () {
                  showDateRangePicker(
                    locale: const Locale("vi", "VI"),
                    context: context,
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2050),
                  ).then((value) => print("thời gian đã chọn: $value"));
                },
                child: const Icon(Icons.calendar_today_outlined,
                    color: ColorResources.PRIMARY),
              ),
            ),
          ],
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios)),
          backgroundColor: ColorResources.WHITE,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text(
            "Đội nhóm",
            style: TextStyle(color: ColorResources.BLACK),
          ),
        ),
        body: GetBuilder<GroupController>(
          init: GroupController(),
          builder: (GroupController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Stack(
              children: [
                Image.asset(
                  Images.admin_background,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: DeviceUtils.getScaledSize(context, 0.05),
                        top: DeviceUtils.getScaledSize(context, 0.127)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // avatar
                        _avatarUser(
                            context, controller.userModel.avatar.toString()),

                        SizedBox(
                            width: DeviceUtils.getScaledSize(context, 0.04)),

                        // info of user
                        _infoUser(
                            context,
                            controller.userModel.fullname.toString(),
                            controller.userModel.username.toString(),
                            Colors.black,
                            Colors.black,
                            100)
                      ],
                    )),
                Container(
                  height: DeviceUtils.getScaledHeight(context, 0.65),
                  padding: EdgeInsets.symmetric(
                      vertical: DeviceUtils.getScaledSize(context, 0.03)),
                  transform: Matrix4.translationValues(
                      0, DeviceUtils.getScaledSize(context, 0.458), 1),
                  decoration: const BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView.builder(
                      itemCount: controller.subTeamsResponse.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      DeviceUtils.getScaledSize(context, 0.03)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${index + 1}",
                                      style: Dimensions.fontSizeStyle18w600(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  DeviceUtils.getScaledSize(
                                                      context, 0.025)),
                                          height: DeviceUtils.getScaledSize(
                                              context, 0.12),
                                          width: DeviceUtils.getScaledSize(
                                              context, 0.12),
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/avatar_account.png")),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Text(controller
                                            .subTeamsResponse[index].fullname
                                            .toString()),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Align(
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            DeviceUtils.getScaledSize(
                                                context, 0.015)),
                                        decoration: BoxDecoration(
                                            color: ColorResources.GREY,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Text(
                                          PriceConverter.convertPrice(
                                                  context,
                                                  double.parse(controller
                                                      .subTeamsResponse[index]
                                                      .revenue!))
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    DeviceUtils.getScaledSize(context, 0.01),
                                horizontal:
                                    DeviceUtils.getScaledSize(context, 0.05),
                              ),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            );
          },
        ));
  }
}
