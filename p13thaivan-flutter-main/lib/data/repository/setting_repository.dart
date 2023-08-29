import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/setting_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class SettingRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  SettingRepository();

  ///
  /// Get all settings
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/settings');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert setting to database
  ///
  Future<ApiResponse> add(SettingModel data) async {
    try {
      final response = await dioClient!.post('/settings', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update setting to database
  ///
  Future<ApiResponse> update(SettingModel data) async {
    try {
      final response = await dioClient!.put('/settings', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update setting to database
  ///
  Future<ApiResponse> delete(String id, SettingModel data) async {
    try {
      final response =
          await dioClient!.delete('/settings/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate settings "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/settings/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/settings/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find setting by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/settings/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
