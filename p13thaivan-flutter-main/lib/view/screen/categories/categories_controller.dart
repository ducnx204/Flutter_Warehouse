import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/body/category_model.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/routes/app_routes.dart';

class CategoriesController extends GetxController
    with SingleGetTickerProviderMixin {
  // refresh controller for load more refresh
  List<RefreshController>? refreshControllerList;

  CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();
  ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  bool isLoading = true;
  bool isLoadingListView = true;

  TabController? tabController;

  List<CategoryModel> categoriesList = [];
  List<ProductModel> productList = [];
  ProductModel? productWithId;

  // page for for load more refresh
  int page = 1;
  int limit = 6;

  @override
  void onInit() {
    super.onInit();
    // get all categries
    getAllCategories();
  }

  @override
  void onClose() {
    super.onClose();
    tabController!.dispose();
    refreshControllerList!.clear();
  }

  ///
  ///lấy tất cả danh mục
  ///
  void getAllCategories() {
    categoryProvider.all(onSuccess: (value) {
      categoriesList = value;

      // binding data tab
      tabController = TabController(length: categoriesList.length, vsync: this);

      // binding refresh controller
      refreshControllerList =
          List.generate(categoriesList.length, (_) => RefreshController());

      // listen tab controller
      listenerTabController();

      // set tab active
      final int tabIndex = int.parse(Get.parameters['indexTab'].toString());

      if (tabIndex == 0) {
        // load data product with id categories with index 0
        getProductWithIdCategory(isRefresh: true);
      } else {
        tabController!.index = int.parse(Get.parameters['indexTab'].toString());
      }

      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///listener tabController
  ///
  void listenerTabController() {
    // listen tab
    tabController!.addListener(() {
      // check call first time
      if (tabController!.indexIsChanging) {
        // add loading and clear data
        isLoadingListView = true;
        productList.clear();
        update();

        // load data product with id categories
        getProductWithIdCategory(isRefresh: true);
      }
    });
  }

  ///
  /// get products with category new
  ///
  void getProductWithIdCategory({required bool isRefresh}) {
    // get current id category
    final String currentIdCategory =
        categoriesList[tabController!.index].id.toString();

    // is refresh
    if (isRefresh) {
      page = 1;
      productList.clear();
    } else {
      // is loading
      page++;
    }

    // get products item by category id
    productProvider.paginate(
      page: page,
      limit: limit,
      filter: "&idCategory=$currentIdCategory&sortBy=created_at:desc",
      onSuccess: (value) {
        // check data is empty
        if (value.isEmpty) {
          refreshControllerList![tabController!.index].loadNoData();
        } else {
          // is refresh
          if (isRefresh) {
            productList = value;
            refreshControllerList![tabController!.index].refreshCompleted();
          } else {
            // is load more
            productList = productList.toList() + value;
            refreshControllerList![tabController!.index].loadComplete();
          }
        }

        isLoadingListView = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// onRefresh
  ///
  Future onRefresh() async {
    refreshControllerList![tabController!.index].resetNoData();
    getProductWithIdCategory(isRefresh: true);
  }

  ///
  /// onLoading
  ///
  Future onLoading() async {
    getProductWithIdCategory(isRefresh: false);
  }

  ///
  ///xem sản phẩm
  ///
  void onProductClick(int index) {
    productProvider
        .find(
            id: productList[index].id!,
            onSuccess: (value) {
              productWithId = value;

              update();
            },
            onError: (error) {
              print(error);
              update();
            })
        .then((values) => Get.toNamed(
            "${AppRoutes.PRODUCT_DETAIL}?productId=${productList[index].id!}&categoryId=${productList[index].idCategory}&price=${productList[index].prices}"));
  }
}
