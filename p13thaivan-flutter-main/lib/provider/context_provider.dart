import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/context_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/context_repository.dart';

class ContextProvider {
  ContextRepository? regionRepo = GetIt.I.get<ContextRepository>();

  ContextProvider();

  ///
  /// Get all contexts
  ///
  Future<void> all({
    required Function(List<ContextModel> contexts) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => ContextModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert context to database
  ///
  Future<void> add({
    required ContextModel data,
    required Function(ContextModel context) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ContextModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update context to database
  ///
  Future<void> update({
    required ContextModel data,
    required Function(ContextModel context) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ContextModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete context to database
  ///
  Future<void> delete({
    required String id,
    required ContextModel data,
    required Function(ContextModel context) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ContextModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate contexts "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ContextModel> contexts) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => ContextModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete context to database
  ///
  Future<void> find({
    required String id,
    required Function(ContextModel context) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ContextModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
