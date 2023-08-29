import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/categories/categories_controller.dart';

class CategoriesPage extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
        init: CategoriesController(),
        builder: (controller) {
          if (controller.isLoading) {
            return Container(
                color: ColorResources.WHITE,
                child: const Center(child: CircularProgressIndicator()));
          }

          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios)),
              elevation: 1,
              centerTitle: true,
              backgroundColor: ColorResources.WHITE,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                "Danh mục",
                style: TextStyle(color: ColorResources.BLACK),
              ),

              //tabbar
              bottom: TabBar(
                controller: controller.tabController,
                isScrollable: true,
                indicatorColor: ColorResources.PRIMARY,
                labelColor: ColorResources.PRIMARY,
                unselectedLabelColor: Colors.grey,
                tabs: controller.categoriesList
                    .map((categories) => Tab(text: categories.name))
                    .toList(),
              ),
            ),

            // tabbar view
            body: TabBarView(
              controller: controller.tabController,
              children: [
                ...List.generate(
                  controller.categoriesList.length,
                  (index) => GetBuilder<CategoriesController>(
                      init: CategoriesController(),
                      builder: (controller) {
                        if (controller.isLoadingListView) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        // item products
                        return _itemProduct(context,
                            indexRefreshController: index);
                      }),
                ).toList()
              ],
            ),
          );
        });
  }

  ///
  /// item product
  ///
  Widget _itemProduct(BuildContext context,
      {required int indexRefreshController}) {
    return Scrollbar(
        child: SmartRefresher(
            controller:
                controller.refreshControllerList![indexRefreshController],
            enablePullUp: true,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: (controller.productList.isEmpty)
                ? const Center(
                    child: Text("Không có sản phẩm"),
                  )
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.72,
                      crossAxisCount: 2,
                    ),
                    itemCount: controller.productList.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.onProductClick(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.WHITE),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    image: controller
                                        .productList[index].thumbnail!,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                      Images.placeholder,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: DeviceUtils.getScaledHeight(
                                      context, 0.01)),
                              SizedBox(
                                height:
                                    DeviceUtils.getScaledSize(context, 0.101),
                                child: Text(
                                  controller.productList[index].name!,
                                  maxLines: 2,
                                  style: Dimensions.fontSizeStyle14w600(),
                                ),
                              ),
                              Text(PriceConverter.convertPrice(
                                  context,
                                  double.tryParse(controller
                                              .productList[index].prices!) ==
                                          null
                                      // nếu mà không để giá thì sẽ parse thành 10 triệu
                                      ? 10000000
                                      : double.tryParse(controller
                                          .productList[index].prices!)!))
                            ],
                          ),
                        ),
                      );
                    })));
  }
}
