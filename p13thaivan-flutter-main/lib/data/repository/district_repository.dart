import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/district_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DistrictRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DistrictRepository();

  ///
  /// Get all districts
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/districts');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert district to database
  ///
  Future<ApiResponse> add(DistrictModel data) async {
    try {
      final response = await dioClient!.post('/districts', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update district to database
  ///
  Future<ApiResponse> update(DistrictModel data) async {
    try {
      final response = await dioClient!.put('/districts', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update district to database
  ///
  Future<ApiResponse> delete(String id, DistrictModel data) async {
    try {
      final response =
          await dioClient!.delete('/districts/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate districts "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/districts/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/districts/paginate?page=$page&limit=$limit&$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find district by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/districts/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
