import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/news_model.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/news_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsDetailController extends GetxController {
  NewsProvider newsProvider = GetIt.I.get<NewsProvider>();

  NewsModel? newsModel;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getNewsFromId();
  }

  ///
  ///get news from id
  ///
  void getNewsFromId() {
    newsProvider.find(
        id: Get.parameters['idNews'].toString(),
        onSuccess: (value) {
          newsModel = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

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
