import 'package:get/get.dart';
import 'package:template/view/screen/account/account_controller.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/screen/leaderboard/leaderboard_controller.dart';
import 'package:template/view/screen/news/news_controller.dart'; 

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<LeaderBoardController>(() => LeaderBoardController());
    Get.lazyPut<NewsController>(() => NewsController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
