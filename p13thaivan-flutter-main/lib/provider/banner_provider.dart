import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/banner_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/banner_repository.dart';

class BannerProvider {
  BannerRepository? regionRepo = GetIt.I.get<BannerRepository>();

  BannerProvider();

  ///
  /// Get all banners
  ///
  Future<void> all({
    required Function(List<BannerModel> banners) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert banner to database
  ///
  Future<void> add({
    required BannerModel data,
    required Function(BannerModel banner) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BannerModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update banner to database
  ///
  Future<void> update({
    required BannerModel data,
    required Function(BannerModel banner) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BannerModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete banner to database
  ///
  Future<void> delete({
    required String id,
    required BannerModel data,
    required Function(BannerModel banner) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BannerModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate banners "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<BannerModel> banners) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete banner to database
  ///
  Future<void> find({
    required String id,
    required Function(BannerModel banner) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(BannerModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
