import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/category_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class CategoryRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  CategoryRepository();

  ///
  /// Get all categorys
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/categorys');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert category to database
  ///
  Future<ApiResponse> add(CategoryModel data) async {
    try {
      final response = await dioClient!.post('/categorys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update category to database
  ///
  Future<ApiResponse> update(CategoryModel data) async {
    try {
      final response = await dioClient!.put('/categorys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update category to database
  ///
  Future<ApiResponse> delete(String id, CategoryModel data) async {
    try {
      final response =
          await dioClient!.delete('/categorys/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate categorys "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/categorys/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/categorys/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find category by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/categorys/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
