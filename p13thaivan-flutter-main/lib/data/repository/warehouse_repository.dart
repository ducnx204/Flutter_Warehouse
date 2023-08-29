import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/warehouse_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class WarehouseRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  WarehouseRepository();

  ///
  /// Get all warehouses
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/warehouses');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert warehouse to database
  ///
  Future<ApiResponse> add(WarehouseModel data) async {
    try {
      final response = await dioClient!.post('/warehouses', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update warehouse to database
  ///
  Future<ApiResponse> update(WarehouseModel data) async {
    try {
      final response = await dioClient!.put('/warehouses', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update warehouse to database
  ///
  Future<ApiResponse> delete(String id, WarehouseModel data) async {
    try {
      final response =
          await dioClient!.delete('/warehouses/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate warehouses "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/warehouses/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/warehouses/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find warehouse by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/warehouses/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
