import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/role_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class RoleRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  RoleRepository();

  ///
  /// Get all roles
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/roles');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert role to database
  ///
  Future<ApiResponse> add(RoleModel data) async {
    try {
      final response = await dioClient!.post('/roles', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update role to database
  ///
  Future<ApiResponse> update(RoleModel data) async {
    try {
      final response = await dioClient!.put('/roles', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update role to database
  ///
  Future<ApiResponse> delete(String id, RoleModel data) async {
    try {
      final response =
          await dioClient!.delete('/roles/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate roles "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/roles/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/roles/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find role by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/roles/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
