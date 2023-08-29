import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ProductRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ProductRepository();

  ///
  /// Get all products
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/products');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert product to database
  ///
  Future<ApiResponse> add(ProductModel data) async {
    try {
      final response = await dioClient!.post('/products', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update product to database
  ///
  Future<ApiResponse> update(ProductModel data) async {
    try {
      final response = await dioClient!.put('/products', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update product to database
  ///
  Future<ApiResponse> delete(String id, ProductModel data) async {
    try {
      final response =
          await dioClient!.delete('/products/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate products "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/products/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/products/paginate?page=$page&limit=$limit&$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find product by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/products/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
