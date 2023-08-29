import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/gen_user_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/static_user_response.dart';
import 'package:template/data/model/response/sub_team_response.dart';
import 'package:template/data/repository/user_repository.dart';

class UserProvider {
  UserRepository? userRepo = GetIt.I.get<UserRepository>();

  UserProvider();

  ///
  /// Get all users
  ///
  Future<void> all({
    required Function(List<UserModel> users) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await userRepo!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert user to database
  ///
  Future<void> add({
    required UserModel data,
    required Function(UserModel user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await userRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Gen username
  ///
  Future<void> genUsername({
    required Function(GenUserModel user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await userRepo!.genUsername();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(GenUserModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update user to database
  ///
  Future<void> update({
    required UserModel data,
    required Function(UserModel user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await userRepo!.update(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update user to database
  ///
  Future<void> updateDeviceToken({
    required String id,
    required String deviceToken,
    required Function(UserModel user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await userRepo!.updateDeviceToken(id, deviceToken);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update address order to database
  ///
  Future<void> addressOrderUpdate({
    required UserModel data,
    required Function(UserModel user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await userRepo!.addressOrderUpdate(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update user to database
  ///
  Future<void> infoUpdate({
    required Map<String, String> data,
    required Function(UserModel user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await userRepo!.infoUpdate(data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete user to database
  ///
  Future<void> delete({
    required String id,
    required UserModel data,
    required Function(UserModel user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await userRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate users "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<UserModel> users) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await userRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete user to database
  ///
  Future<void> find({
    required String id,
    required Function(UserModel user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await userRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserModel.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Check username exists
  ///
  Future<void> checkUsernameExists({
    required String username,
    required Function(UserModel user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await userRepo!.checkUsernameExists(username);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      if (results.toString() != '') {
        onSuccess(UserModel.fromJson(results as Map<String, dynamic>));
      } else {
        onSuccess(UserModel());
      }
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// get sub team of user
  ///
  Future<void> getSubTeamUser({
    required String idUser,
    required Function(List<SubTeamResponse> user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await userRepo!.getSubTeamUser(idUser);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      if (results.toString() != '') {
        onSuccess(results
            .map((e) => SubTeamResponse.fromJson(e as Map<String, dynamic>))
            .toList());
      } else {
        onSuccess([]);
      }
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// statis user
  ///
  Future<void> statisUser({
    required String idUser,
    required Function(StaticUserResponse user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await userRepo!.statisUser(idUser);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      if (results.toString() != '') {
        onSuccess(StaticUserResponse.fromJson(results as Map<String, dynamic>));
      } else {
        onSuccess(StaticUserResponse());
      }
    } else {
      onError(apiResponse.error);
    }
  }
}
