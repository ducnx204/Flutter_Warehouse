import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/personal_honor_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/personal_honors_reponse_model.dart';
import 'package:template/data/repository/personal_honor_repository.dart';

class PersonalHonorProvider {
  PersonalHonorRepository? regionRepo = GetIt.I.get<PersonalHonorRepository>();

  PersonalHonorProvider();

  ///
  /// Get all personalHonors
  ///
  Future<void> all({
    required Function(List<PersonalHonorModel> personalHonors) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => PersonalHonorModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert personalHonor to database
  ///
  Future<void> add({
    required PersonalHonorModel data,
    required Function(PersonalHonorModel personalHonor) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(PersonalHonorModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update personalHonor to database
  ///
  Future<void> update({
    required PersonalHonorModel data,
    required Function(PersonalHonorModel personalHonor) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(PersonalHonorModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete personalHonor to database
  ///
  Future<void> delete({
    required String id,
    required PersonalHonorModel data,
    required Function(PersonalHonorModel personalHonor) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(PersonalHonorModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate personalHonors "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<PersonalHonorModel> personalHonors) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => PersonalHonorModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate personalHonors "page": 1, "limit": 10
  ///
  Future<void> findByIdContext({
    required int page,
    required int limit,
    required String idContext,
    required Function(List<PersonalHonorsResponseModel> personalHonors)
        onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await regionRepo!.findByIdContext(page, limit, idContext);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) =>
              PersonalHonorsResponseModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete personalHonor to database
  ///
  Future<void> find({
    required String id,
    required Function(PersonalHonorModel personalHonor) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(PersonalHonorModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
