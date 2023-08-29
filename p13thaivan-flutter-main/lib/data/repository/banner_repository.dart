import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/banner_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class BannerRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  BannerRepository();

  ///
  /// Get all banners
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/banners');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert banner to database
  ///
  Future<ApiResponse> add(BannerModel data) async {
    try {
      final response = await dioClient!.post('/banners', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update banner to database
  ///
  Future<ApiResponse> update(BannerModel data) async {
    try {
      final response = await dioClient!.put('/banners', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update banner to database
  ///
  Future<ApiResponse> delete(String id, BannerModel data) async {
    try {
      final response =
          await dioClient!.delete('/banners/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate banners "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/banners/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/banners/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find banner by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/banners/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
