import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/context_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ContextRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ContextRepository();

  ///
  /// Get all contexts
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/contexts');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert context to database
  ///
  Future<ApiResponse> add(ContextModel data) async {
    try {
      final response = await dioClient!.post('/contexts', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update context to database
  ///
  Future<ApiResponse> update(ContextModel data) async {
    try {
      final response = await dioClient!.put('/contexts', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update context to database
  ///
  Future<ApiResponse> delete(String id, ContextModel data) async {
    try {
      final response =
          await dioClient!.delete('/contexts/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate contexts "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/contexts/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/contexts/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find context by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/contexts/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
