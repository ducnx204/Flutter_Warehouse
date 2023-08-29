import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/category_news_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class CategoryNewsRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  CategoryNewsRepository();

  ///
  /// Get all category-newss
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/category-newss');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert category-news to database
  ///
  Future<ApiResponse> add(CategoryNewsModel data) async {
    try {
      final response =
          await dioClient!.post('/category-newss', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update category-news to database
  ///
  Future<ApiResponse> update(CategoryNewsModel data) async {
    try {
      final response =
          await dioClient!.put('/category-newss', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update category-news to database
  ///
  Future<ApiResponse> delete(String id, CategoryNewsModel data) async {
    try {
      final response =
          await dioClient!.delete('/category-newss/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate category-newss "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri =
          '/category-newss/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/category-newss/paginate?page=$page&limit=$limit&$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find category-news by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/category-newss/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
