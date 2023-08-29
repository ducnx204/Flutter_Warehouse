import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/import_ware_house_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ImportWareHouseRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ImportWareHouseRepository();

  ///
  /// Get all import-ware-houses
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/import-ware-houses');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert import-ware-house to database
  ///
  Future<ApiResponse> add(ImportWareHouseModel data) async {
    try {
      final response = await dioClient!.post('/import-ware-houses', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update import-ware-house to database
  ///
  Future<ApiResponse> update(ImportWareHouseModel data) async {
    try {
      final response = await dioClient!.put('/import-ware-houses', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update import-ware-house to database
  ///
  Future<ApiResponse> delete(String id, ImportWareHouseModel data) async {
    try {
      final response =
          await dioClient!.delete('/import-ware-houses/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate import-ware-houses "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/import-ware-houses/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/import-ware-houses/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find import-ware-house by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/import-ware-houses/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
