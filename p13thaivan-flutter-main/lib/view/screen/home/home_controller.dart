import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/banner_model.dart';
import 'package:template/data/model/body/category_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/static_user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/banner_provider.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class HomeController extends GetxController {
  UserProvider userProvider = GetIt.I.get<UserProvider>();
  CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();
  BannerProvider bannerProvider = GetIt.I.get<BannerProvider>();

  UserModel? userModel;
  StaticUserResponse staticUserResponse = StaticUserResponse();

  // banner
  List<CategoryModel> categoriesList = [];
  List<BannerModel> bannerList = [];

  int categoryPages = 0;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    sl.get<SharedPreferenceHelper>().userId.then(
      (userId) {

        // load data user by id
        getUserById(userId!);
      },
    );

    // load data categories
    getAllCategory();

    // load data banner
    getAllBanner();
  }

  ///
  /// lấy thông tin user
  ///
  void getUserById(String userId) {
    // load data user by id

    userProvider.find(
      id: userId,
      onSuccess: (data) {
        userModel = data;
        // load data revanue and statistical of team
        userProvider.statisUser(
          idUser: userId,
          onSuccess: (data) {
            staticUserResponse = data;
            isLoading = false;
            update();
          },
          onError: (error) {
            print(error);
          },
        );
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  ///get all categ
  ///
  void getAllCategory() {
    categoryProvider.all(onSuccess: (value) {
      categoriesList = value;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///get all categ
  ///
  void getAllBanner() {
    bannerProvider.all(onSuccess: (value) {
      bannerList = value;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///onCartClick
  ///
  void onCartClick() {
    Get.toNamed(AppRoutes.CARTS);
  }

  ///
  /// onRegisterIdClick
  ///
  void onRegisterIdClick() {
    Get.toNamed(AppRoutes.INFORMATION_USER);
  }

  ///
  /// onBtnCategoriesClick
  ///
  void onBtnCategoriesClick(int? index) {
    Get.toNamed(
        "${AppRoutes.CATEGORIES}?indexTab=$index&idCategory=${categoriesList[index!].id}")!;
  }

  ///
  /// onProductVoucherClick
  ///
  void onProductVoucherClick() {
    Get.toNamed(AppRoutes.KHOHANGTROGIA);
  }

  ///
  /// onBtnKhoHangDieuKienClick
  ///
  void onBtnKhoHangDieuKienClick() {
    Get.toNamed(AppRoutes.KHOHANGDIEUKIEN);
  }

  ///
  /// onBtnKhoHangVienNenClick
  ///
  void onBtnKhoHangVienNenClick() {
    Get.toNamed(AppRoutes.KHO_HANG_VIEN_NEN);
  }

  ///
  /// onGroupClick
  ///
  void onGroupClick() {
    Get.toNamed(AppRoutes.GROUP);
  }
}
