import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class OrderController extends GetxController with SingleGetTickerProviderMixin {
  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  List<List<OrderModel>> orderStatusList = [[], [], [], [], []];
  List<OrderModel> orderList = [];

  bool isLoading = true;

  int indexTab = 0;

  Map<String, String> statusPayment = {
    "1": "Chưa thanh toán",
    "2": "Đã thanh toán",
  };
  Map<String, String> statusLabel = {
    "1": "Mới tạo",
    "2": "Đang xử lý",
    "3": "Đã vận chuyển",
    "4": "Đã giao hàng",
    "5": "Hủy đơn",
  };
  Map<String, Color> statusColor = {
    "1": const Color(0xff007D3A),
    "2": const Color(0xff0D5BB5),
    "3": const Color(0xffCC8100),
    "4": const Color(0xffBF1D28),
    "5": const Color(0xffA6A6B0),
  };

  Map<String, Color> statusBackgroundColor = {
    "1": const Color(0x1f007D3A),
    "2": const Color(0x1f0D5BB5),
    "3": const Color(0x1fCC8100),
    "4": const Color(0x1fBF1D28),
    "5": const Color(0x1fA6A6B0),
  };

  String? userId;

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      getOrderbyIdUser();
    });
    indexTab = int.parse(Get.parameters['indexTab'].toString());
    update();
  }

  ///
  ///get order by id user
  ///
  void getOrderbyIdUser() {
    sl
        .get<SharedPreferenceHelper>()
        .userId
        .then((value) => orderProvider.paginate(
            page: 1,
            limit: 100,
            filter: "idUser=$value&sortBy=_id:desc",
            onSuccess: (value) {
              orderList = value;
              value.forEach((element) {
                if (element.statusOrder != "0") {
                  orderStatusList[int.parse(element.statusOrder!) - 1]
                      .add(element);
                }
                isLoading = false;
                update();
              });
            },
            onError: (error) {
              print(error);
            }));
  }

  ///
  ///convert Date
  ///
  String convertDateTime(String orderDate) {
    final loadedTime = DateConverter.isoStringToLocalDateHMS(
        orderDate.replaceAll("T", " ").substring(0, orderDate.length - 1));
    return loadedTime;
  }

  ///
  /// on Order Widget Click
  ///
  void onOrderWidgetClick({int? i, String? index, int? indexTabAll}) {
    if (indexTabAll != null) {
      Get.toNamed(
          "${AppRoutes.ORDER_DETAIL}?idOrder=${orderList[indexTabAll].id}");
    } else {
      Get.toNamed(
          "${AppRoutes.ORDER_DETAIL}?idOrder=${orderStatusList[int.parse(index!) - 1][i!].id}");
    }
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
