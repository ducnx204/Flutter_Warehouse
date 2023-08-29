import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/optional_role_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class OptionalRoleRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  OptionalRoleRepository();

  ///
  /// Get all optional-roles
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/optional-roles');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert optional-role to database
  ///
  Future<ApiResponse> add(OptionalRoleModel data) async {
    try {
      final response = await dioClient!.post('/optional-roles', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update optional-role to database
  ///
  Future<ApiResponse> update(OptionalRoleModel data) async {
    try {
      final response = await dioClient!.put('/optional-roles', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update optional-role to database
  ///
  Future<ApiResponse> delete(String id, OptionalRoleModel data) async {
    try {
      final response =
          await dioClient!.delete('/optional-roles/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate optional-roles "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/optional-roles/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/optional-roles/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find optional-role by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/optional-roles/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
