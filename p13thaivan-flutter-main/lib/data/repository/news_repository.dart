import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/news_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class NewsRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  NewsRepository();

  ///
  /// Get all newss
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/newss');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert news to database
  ///
  Future<ApiResponse> add(NewsModel data) async {
    try {
      final response = await dioClient!.post('/newss', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update news to database
  ///
  Future<ApiResponse> update(NewsModel data) async {
    try {
      final response = await dioClient!.put('/newss', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update news to database
  ///
  Future<ApiResponse> delete(String id, NewsModel data) async {
    try {
      final response =
          await dioClient!.delete('/newss/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate newss "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/newss/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/newss/paginate?page=$page&limit=$limit&$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find news by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/newss/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
