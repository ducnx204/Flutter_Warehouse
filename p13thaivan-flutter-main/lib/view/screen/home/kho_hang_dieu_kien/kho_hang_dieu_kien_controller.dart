import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/screen/register/order_condition/order_condition_page.dart';

class KhoHangDieuKienController extends GetxController {
  ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  UserProvider userProvider = GetIt.I.get<UserProvider>();

  UserModel? userModel;

  List<ProductModel> productList = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getProduct();

    sl.get<SharedPreferenceHelper>().userId.then(
          (userId) {

        // load data user by id
        getUserById(userId!);
      },
    );
  }

  ///
  /// lấy tất cả sản phẩm
  ///
  void getProduct() {
    productProvider.paginate(
        page: 1,
        limit: 100,
        filter: "type=1",
        onSuccess: (value) {
          productList = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
        });
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

      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// on item click
  ///
  void onItemClick(){
    // chạy qua kho để mua kho hàng điều kiện

    // sent data user to order condition page
    Get.to(OrderConditionPage(user: userModel!, isRegister: false, isCondition: true,));
  }

}
