import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/personal_honor_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class PersonalHonorRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  PersonalHonorRepository();

  ///
  /// Get all personal-honors
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/personal-honors');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert personal-honor to database
  ///
  Future<ApiResponse> add(PersonalHonorModel data) async {
    try {
      final response =
          await dioClient!.post('/personal-honors', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update personal-honor to database
  ///
  Future<ApiResponse> update(PersonalHonorModel data) async {
    try {
      final response =
          await dioClient!.put('/personal-honors', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update personal-honor to database
  ///
  Future<ApiResponse> delete(String id, PersonalHonorModel data) async {
    try {
      final response =
          await dioClient!.delete('/personal-honors/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate personal-honors "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri =
          '/personal-honors/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/personal-honors/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate personal-honors "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> findByIdContext(
      int page, int limit, String idContext) async {
    try {
      String uri =
          '/personal-honors/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (idContext != '') {
        uri = '/personal-honors/paginate?page=$page&limit=$limit$idContext';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find personal-honor by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/personal-honors/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
