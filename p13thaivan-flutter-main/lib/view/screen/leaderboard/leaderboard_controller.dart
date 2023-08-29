import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/context_model.dart';
import 'package:template/provider/context_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:html/parser.dart';

class LeaderBoardController extends GetxController {
  ContextProvider contextProvider = GetIt.I.get<ContextProvider>();

  List<ContextModel> contextList = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getAllContext();
  }

  ///
  ///on Charts Click
  ///
  void onChartsClick(int index) {
    Get.toNamed("${AppRoutes.CHARTS}?idChart=${contextList[index].id}");
  }

  ///
  ///load list context
  ///
  void getAllContext() {
    contextProvider.all(onSuccess: (value) {
      contextList = value;
      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///  parse Html String
  ///
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}
