import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/body/category_news_model.dart';
import 'package:template/data/model/body/news_model.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/category_news_provider.dart';
import 'package:template/provider/news_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsController extends GetxController with SingleGetTickerProviderMixin {
  TabController? tabController;

  // refresh controller for load more refresh
  List<RefreshController>? refreshControllerList;

  CategoryNewsProvider categoryNewsProvider =
      GetIt.I.get<CategoryNewsProvider>();
  final searchController = TextEditingController();
  NewsProvider newsProvider = GetIt.I.get<NewsProvider>();
  List<CategoryNewsModel> categoryNewsList = [];
  List<NewsModel> newsList = [];
  NewsModel? newsModel;

  // page for for load more refresh
  int page = 1;
  int limit = 5;

  bool isLoading = true;
  bool isLoadingNews = true;

  int isSelectedIndexTab = 0;
  int isSelectedIndexNews = 0;

  @override
  void onInit() {
    super.onInit();
    getAllCategoryNews();
  }

  @override
  void onClose() {
    super.onClose();
    tabController!.dispose();
    refreshControllerList!.clear();
  }

  ///
  ///get all categoryNews
  ///
  void getAllCategoryNews() {
    categoryNewsProvider.all(onSuccess: (value) {
      categoryNewsList = value;

      // binding data tab
      tabController =
          TabController(vsync: this, length: categoryNewsList.length);

      // binding refresh controller
      refreshControllerList =
          List.generate(categoryNewsList.length, (_) => RefreshController());

      // load data product with id categories
      getNewsWithIdCategory(isRefresh: true);

      // listen tab controller
      listenerTabController();

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
        isLoadingNews = true;
        newsList.clear();
        update();

        // load data product with id categories
        getNewsWithIdCategory(isRefresh: true);
      }
    });
  }

  ///
  /// get news with category new
  ///
  void getNewsWithIdCategory({required bool isRefresh}) {
    // get current id category
    final String currentIdCategory =
        categoryNewsList[tabController!.index].id.toString();

    // is refresh
    if (isRefresh) {
      page = 1;
      newsList.clear();
    } else {
      // is loading
      page++;
    }

    // get news item by category id
    newsProvider.paginate(
      page: page,
      limit: limit,
      filter: "&idCategoryNews=$currentIdCategory&sortBy=created_at:desc",
      onSuccess: (value) {
        // check data is empty
        if (value.isEmpty) {
          refreshControllerList![tabController!.index].loadNoData();
        } else {
          // is refresh
          if (isRefresh) {
            newsList = value;
            refreshControllerList![tabController!.index].refreshCompleted();
          } else {
            // is load more
            newsList = newsList.toList() + value;
            refreshControllerList![tabController!.index].loadComplete();
          }
        }

        isLoadingNews = false;
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
    getNewsWithIdCategory(isRefresh: true);
  }

  ///
  /// onLoading
  ///
  Future onLoading() async {
    getNewsWithIdCategory(isRefresh: false);
  }

  ///
  ///view news
  ///
  void onClickNewsDetail({required int index}) {
    Get.toNamed("${AppRoutes.NEWS_DETAIL}?idNews=${newsList[index].id}");
  }

  ///
  ///time diff
  ///
  String timeAgo(String dateTime) {
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    final String time = dateTime;
    final loadedTime = DateConverter.convertStringToDatetime(
        time.replaceAll("T", " ").substring(0, time.length - 1));
    final now = DateTime.now();
    final difference = now.difference(loadedTime);
    return timeago.format(now.subtract(difference), locale: "vi");
  }
}
