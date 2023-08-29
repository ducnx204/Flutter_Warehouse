import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/province_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ProvinceRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ProvinceRepository();

  ///
  /// Get all provinces
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/provinces');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert province to database
  ///
  Future<ApiResponse> add(ProvinceModel data) async {
    try {
      final response = await dioClient!.post('/provinces', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update province to database
  ///
  Future<ApiResponse> update(ProvinceModel data) async {
    try {
      final response = await dioClient!.put('/provinces', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update province to database
  ///
  Future<ApiResponse> delete(String id, ProvinceModel data) async {
    try {
      final response =
          await dioClient!.delete('/provinces/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate provinces "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/provinces/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/provinces/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find province by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/provinces/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
