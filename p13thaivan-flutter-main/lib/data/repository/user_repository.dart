import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class UserRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  UserRepository();

  ///
  /// Get all users
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/users');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert user to database
  ///
  Future<ApiResponse> add(UserModel data) async {
    try {
      final response = await dioClient!.post('/users', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert user to database
  ///
  Future<ApiResponse> genUsername() async {
    try {
      final response = await dioClient!.get('/users/gen');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update user to database
  ///
  Future<ApiResponse> update(UserModel data) async {
    try {
      final response =
          await dioClient!.put('/users', data: data.toHaveIdJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update user to database
  ///
  Future<ApiResponse> updateDeviceToken(String id, String deviceToken) async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['deviceToken'] = deviceToken;

      final response = await dioClient!.put('/users/$id', data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update user to database
  ///
  Future<ApiResponse> addressOrderUpdate(UserModel data) async {
    try {
      final response =
          await dioClient!.put('/users', data: data.toJsonHaveId());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update user to database
  ///
  Future<ApiResponse> infoUpdate(Map<String, String> data) async {
    try {
      final response = await dioClient!.put('/users', data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update user to database
  ///
  Future<ApiResponse> delete(String id, UserModel data) async {
    try {
      final response =
          await dioClient!.delete('/users/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate users "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/users/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/users/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find user by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/users/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Check username exists
  ///
  Future<ApiResponse> checkUsernameExists(String username) async {
    try {
      final String uri = '/users/username/$username';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// get sub team of user
  ///
  Future<ApiResponse> getSubTeamUser(String idUser) async {
    try {
      final String uri = '/users/subteam?idUser=$idUser';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// static user
  ///
  Future<ApiResponse> statisUser(String idUser) async {
    try {
      final String uri = '/users/statis?idUser=$idUser';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
