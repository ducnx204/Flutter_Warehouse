import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/educate_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class EducateRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  EducateRepository();

  ///
  /// Get all educates
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/educates');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert educate to database
  ///
  Future<ApiResponse> add(EducateModel data) async {
    try {
      final response = await dioClient!.post('/educates', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update educate to database
  ///
  Future<ApiResponse> update(EducateModel data) async {
    try {
      final response = await dioClient!.put('/educates', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update educate to database
  ///
  Future<ApiResponse> delete(String id, EducateModel data) async {
    try {
      final response =
          await dioClient!.delete('/educates/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate educates "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/educates/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/educates/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find educate by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/educates/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
