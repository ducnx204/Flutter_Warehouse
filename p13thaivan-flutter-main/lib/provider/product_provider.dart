import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/order_item_response_model.dart';
import 'package:template/data/repository/product_repository.dart';

class ProductProvider {
  ProductRepository? regionRepo = GetIt.I.get<ProductRepository>();

  ProductProvider();

  ///
  /// Get all products
  ///
  Future<void> all({
    required Function(List<ProductModel> products) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert product to database
  ///
  Future<void> add({
    required ProductModel data,
    required Function(ProductModel product) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ProductModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update product to database
  ///
  Future<void> update({
    required ProductModel data,
    required Function(ProductModel product) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ProductModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete product to database
  ///
  Future<void> delete({
    required String id,
    required ProductModel data,
    required Function(ProductModel product) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ProductModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate products "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ProductModel> products) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete product to database
  ///
  Future<void> find({
    required String id,
    required Function(ProductModel product) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ProductModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  // ///
  // /// Get paginate products "page": 1, "limit": 10
  // ///
  // Future<void> findByIdOrder({
  //   required int page,
  //   required int limit,
  //   required String idOrder,
  //   required Function(List<OrderItemResponseModel> products) onSuccess,
  //   required Function(dynamic error) onError,
  // }) async {
  //   final ApiResponse apiResponse =
  //       await regionRepo!.findByIdOrder(page, limit, idOrder);
  //   if (apiResponse.response.statusCode! >= 200 &&
  //       apiResponse.response.statusCode! <= 300) {
  //     // call back data success
  //     final results = apiResponse.response.data['results'] as List<dynamic>;
  //     onSuccess(results
  //         .map((e) => OrderItemResponseModel.fromJson(e as Map<String, dynamic>))
  //         .toList());
  //   } else {
  //     onError(apiResponse.error);
  //   }
  // }
}
