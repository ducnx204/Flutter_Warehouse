import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class OrderItemRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  OrderItemRepository();

  ///
  /// Get all order-items
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/order-items');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert order-item to database
  ///
  Future<ApiResponse> add(OrderItemModel data) async {
    try {
      final response =
          await dioClient!.post('/order-items', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update order-item to database
  ///
  Future<ApiResponse> update(OrderItemModel data) async {
    try {
      final response =
          await dioClient!.put('/order-items', data: data.toJsonPut());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update order-item to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response = await dioClient!.delete('/order-items/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate order-items "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/order-items/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/order-items/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find order-item by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/order-items/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate products "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> findByIdOrder(int page, int limit, String idOrder) async {
    try {
      final String uri =
          '/order-items/paginate?page=$page&limit=$limit&idOrder=$idOrder'
              .toString();

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
