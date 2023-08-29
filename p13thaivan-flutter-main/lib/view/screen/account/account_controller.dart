import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/screen/home/home_controller.dart';

class AccountController extends GetxController
    with SingleGetTickerProviderMixin {
  UserProvider userProvider = GetIt.I.get<UserProvider>();
  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  UserModel userModel = UserModel();
  List<OrderModel> orderStatusList = [];

  final homeController = Get.put(HomeController());

  String? userId;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      getUserById();
      getOrder();
    });
  }

  ///
  ///load info user
  ///
  void getUserById() {
    userProvider.find(
      id: userId!,
      onSuccess: (value) {
        userModel = value;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  ///load order
  ///
  void getOrder() {
    orderProvider.paginate(
      filter: 'idUser=$userId',
      limit: 100,
      page: 1,
      onSuccess: (value) {
        orderStatusList = value;
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Thay đổi thông tin
  ///
  void onEditInfoClick() {
    Get.toNamed(AppRoutes.EDIT_INFO)!.then((value) {
      if (value == true) {
        sl.get<SharedPreferenceHelper>().userId.then((value) {
          getUserById();
          getOrder();
          homeController.getUserById(value!);
        });
      }
    });
  }

  ///
  /// tới màn hình rules
  ///
  void onRulesClick() {
    Get.toNamed(AppRoutes.RULES);
  }

  ///
  /// tới màn hình educate
  ///
  void onEducateClick() {
    Get.toNamed(AppRoutes.EDUCATE);
  }

  /// tới màn hình cart
  ///
  void onCartClick() {
    sl.get<SharedPreferenceHelper>().orderId.then((value) {
      Get.toNamed("${AppRoutes.CARTS}?idOrder=$value");
    });
  }

  ///
  ///đăng xuất
  ///
  void onLogoutClick() {
    sl.get<SharedPreferenceHelper>().removeUserId();
    sl.get<SharedPreferenceHelper>().removeIsLogin();
    Get.offNamed(AppRoutes.LOGIN);
  }

  ///
  /// đổi mật khẩu
  ///
  void onChangePasswordClick() {
    Get.toNamed(AppRoutes.PASSWORD_CHANGE);
  }

  ///
  ///tới màn hình order
  ///
  void onOrderClick(int index) {
    update();
    Get.toNamed("${AppRoutes.ORDER}?indexTab=$index");
  }
}
