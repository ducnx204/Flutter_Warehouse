import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/category_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/category_repository.dart';

class CategoryProvider {
  CategoryRepository? regionRepo = GetIt.I.get<CategoryRepository>();

  CategoryProvider();

  ///
  /// Get all categorys
  ///
  Future<void> all({
    required Function(List<CategoryModel> categorys) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      await onSuccess(results
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert category to database
  ///
  Future<void> add({
    required CategoryModel data,
    required Function(CategoryModel category) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CategoryModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update category to database
  ///
  Future<void> update({
    required CategoryModel data,
    required Function(CategoryModel category) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CategoryModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete category to database
  ///
  Future<void> delete({
    required String id,
    required CategoryModel data,
    required Function(CategoryModel category) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CategoryModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate categorys "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<CategoryModel> categorys) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete category to database
  ///
  Future<void> find({
    required String id,
    required Function(CategoryModel category) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CategoryModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
