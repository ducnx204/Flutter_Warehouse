import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
// template
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'news_controller.dart';

class NewsPage extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    const String title = "Tin Tức";
    return GetBuilder<NewsController>(
        init: NewsController(),
        builder: (controller) {
          if (controller.isLoading) {
            return Container(
                color: ColorResources.WHITE,
                child: const Center(child: CircularProgressIndicator()));
          }

          return controller.categoryNewsList.isEmpty
              ? const Center(child: Text("Tin tức trống!"))
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    elevation: 2,
                    title: const Text(
                      title,
                      style: TextStyle(
                        color: Color(0xFF27272A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    shadowColor: const Color(0x3F000000),
                    bottom: TabBar(
                      controller: controller.tabController,
                      isScrollable: true,
                      indicatorColor: ColorResources.PRIMARY,
                      labelColor: ColorResources.PRIMARY,
                      unselectedLabelColor: Colors.grey,
                      tabs: controller.categoryNewsList
                          .map((item) => Tab(child: Text(item.name!)))
                          .toList(),
                    ),
                  ),
                  body: TabBarView(
                    controller: controller.tabController,
                    children: List.generate(
                        controller.categoryNewsList.length,
                        (index) => GetBuilder<NewsController>(
                              builder: (controller) {
                                if (controller.isLoadingNews) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                // item news
                                return _itemNews(context,
                                    indexRefreshController: index);
                              },
                            )).toList(),
                  ),
                );
        });
  }

  ///
  /// item news
  ///
  Widget _itemNews(BuildContext context,
      {required int indexRefreshController}) {
    return Scrollbar(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SmartRefresher(
          controller: controller.refreshControllerList![indexRefreshController],
          enablePullUp: true,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          child: (controller.newsList.isEmpty)
              ? const Center(
                  child: Text("Không có tin tức"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.newsList.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      // onClickNewsDetail
                      onTap: () => controller.onClickNewsDetail(index: index),
                      child: Column(
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .25,
                                  height:
                                      DeviceUtils.getScaledSize(context, 0.25),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: Images.placeholder,
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      image: controller.newsList[index].image!,
                                      fit: BoxFit.cover,
                                      imageErrorBuilder: (c, o, s) =>
                                          Image.asset(
                                        Images.placeholder,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: DeviceUtils.getScaledSize(
                                        context, 0.02)),
                                Container(
                                  height:
                                      DeviceUtils.getScaledSize(context, 0.25),
                                  width: 1,
                                  color: Colors.grey,
                                ),

                                //  text
                                Container(
                                  width: MediaQuery.of(context).size.width * .6,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: DeviceUtils.getScaledSize(
                                          context, 0.015)),
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(controller.newsList[index].name!,
                                              maxLines: 3,
                                              style: const TextStyle(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          SizedBox(
                                              height: DeviceUtils.getScaledSize(
                                                  context, 0.04)),
                                          Text(
                                              controller.timeAgo(controller
                                                  .newsList[index].createdAt!),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_DEFAULT,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey)),
                                        ],
                                      )),
                                ),
                              ]),
                          Padding(
                            padding: EdgeInsets.all(
                                DeviceUtils.getScaledSize(context, 0.025)),
                            child: const Divider(
                              color: ColorResources.GREY,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
