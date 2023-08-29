import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/order_item_response_model.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class OrderDetailController extends GetxController {
  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  List<OrderModel> orderList = [];
  OrderModel orderModel = OrderModel();
  String? orderId;

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  List<OrderItemResponseModel> orderItemList = [];

  UserProvider userProvider = GetIt.I.get<UserProvider>();
  UserModel userModel = UserModel();

  ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  String province = '';

  DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();
  String district = '';

  String? address;

  String? userId;
  int? price;

  String orderTime = '';

  bool isLoading = true;
  bool isLoadingAddress = false;

  Map<String, String> statusLabel = {
    "1": "Mới tạo",
    "2": "Đang xử lý",
    "3": "Đã vận chuyển",
    "4": "Đã giao hàng",
    "5": "Hủy đơn",
  };

  @override
  void onInit() {
    super.onInit();
    orderId = Get.parameters['idOrder'].toString();
    getUserInfo();
    getOrderItem();
    getOrderInfo();
  }

  ///
  ///get order item
  ///
  void getOrderItem() {
    orderItemProvider.findByIdOrder(
        page: 1,
        limit: 100,
        idOrder: orderId.toString(),
        onSuccess: (value) {
          orderItemList = value;
          getPrice();
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///get user info
  ///
  void getUserInfo() {
    isLoadingAddress = true;
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userProvider.find(
          id: value!,
          onSuccess: (data) {
            userModel = data;
            print("aaa ${userModel.addressOrder}");
            isLoadingAddress = false;
            update();
          },
          onError: (error) {
            print(error);
          });
    });
  }

  ///
  ///get order info
  ///
  void getOrderInfo() {
    orderProvider.find(
        id: orderId.toString(),
        onSuccess: (value) {
          orderModel = value;
          if (value.idProvince != '1' || value.idDistrict != '1') {
            getAddress(value.idProvince!, value.idDistrict!);
          }
          convertDateTime(value.updatedAt.toString());
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///convert datetime
  ///
  void convertDateTime(String orderDate) {
    orderTime = DateConverter.isoStringToLocalDateHMS(
        orderDate.replaceAll("T", " ").substring(0, orderDate.length - 1));
  }

  ///
  ///get price total
  ///
  void getPrice() {
    for (var i = 0; i < orderItemList.length; i++) {
      price = int.parse(orderItemList[i].quantity.toString()) *
          int.parse(orderItemList[i].idProduct!.prices.toString());
    }
    isLoading = false;
    update();
  }

  ///
  ///get address from iUser
  ///
  void getAddress(String provinceId, String districtId) {
    //get province
    provinceProvider.find(
        id: provinceId,
        onSuccess: (value) {
          province = value.name!;
          update();
        },
        onError: (error) {
          print(error);
        });
    districtProvider.find(
        id: districtId,
        onSuccess: (value) {
          district = value.name!;
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  /// to Local Date
  ///
  String toLocalDate(String date) {
    final dateValue = DateFormat("HH:mm dd/MM/yyyy").parseUTC(date).toLocal();

    final String formattedDate =
        DateFormat("hh:mm dd/MM/yyyy").format(dateValue);
    return formattedDate;
  }
}
