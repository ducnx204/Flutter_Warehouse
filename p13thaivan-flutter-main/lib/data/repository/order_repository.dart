import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class OrderRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  OrderRepository();

  ///
  /// Get all orders
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/orders');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert order to database
  ///
  Future<ApiResponse> add(OrderModel data) async {
    try {
      final response = await dioClient!.post('/orders', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update order to database
  ///
  Future<ApiResponse> update(OrderModel data) async {
    try {
      final response = await dioClient!.put('/orders', data: data.toJsonPut());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update date order to database
  ///
  Future<ApiResponse> updateData(Map<String, String> data) async {
    try {
      final response = await dioClient!.put('/orders', data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update order to database
  ///
  Future<ApiResponse> delete(String id, OrderModel data) async {
    try {
      final response =
          await dioClient!.delete('/orders/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate orders "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/orders/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/orders/paginate?page=$page&limit=$limit&$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find order by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/orders/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// getWith
  ///
  Future<ApiResponse> getWith(
      String userId, String dateStart, String dateEnd) async {
    try {
      final String uri =
          '/orders/dateStart-dateEnd?idUser=${userId}&dateStart=${dateStart}&dateEnd=${dateEnd}';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
