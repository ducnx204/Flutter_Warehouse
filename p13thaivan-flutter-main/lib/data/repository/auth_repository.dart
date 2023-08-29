import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/request/auth_request.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class AuthRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();
  SharedPreferenceHelper? sharedPreferences =
      GetIt.I.get<SharedPreferenceHelper>();

  AuthRepository();

  ///
  /// Insert user to database
  ///
  Future<ApiResponse> registration(UserModel data) async {
    try {
      final response = await dioClient!.post('/users', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert user to database
  ///
  Future<ApiResponse> login(AuthRequest request) async {
    try {
      final response =
          await dioClient!.post('/auth/login', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // Future<ApiResponse> updateToken() async {
  //   try {
  //     final String _deviceToken = await getDeviceToken();
  //     FirebaseMessaging.instance.subscribeToTopic(app_constants.TOPIC);
  //     final Response response = await dioClient.post(
  //       app_constants.TOKEN_URI,
  //       data: {'_method': 'put', 'cm_firebase_token': _deviceToken},
  //     );
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  ///
  /// get device token
  ///
  Future<String> getDeviceToken() async {
    final String _deviceToken =
        FirebaseMessaging.instance.getToken().toString();
    print('--------Device Token----------  $_deviceToken');
    return _deviceToken;
  }

  ///
  /// save User Token
  ///
  Future<void> saveUserToken(String token) async {
    dioClient!.token = token;
    dioClient!.dio!.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences!.saveJwtToken(token);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// getUserToken
  ///
  String getUserToken() {
    return sharedPreferences!.jwtToken.toString();
  }

  ///
  /// isLoggedIn
  ///
  bool isLoggedIn() {
    return sharedPreferences!.containsKey();
  }

  ///
  /// clearSharedData
  ///
  Future<bool> clearSharedData() async {
    sharedPreferences!.removeJwtToken();
    // FirebaseMessaging.instance.unsubscribeFromTopic(app_constants.TOPIC);
    return true;
  }

  ///
  /// for  Remember Username
  ///
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      sharedPreferences!.saveUsername(email);
      sharedPreferences!.savePassword(password);
    } catch (e) {
      rethrow;
    }
  }

  // String getUserEmail() {
  //   return sharedPreferences.getString(app_constants.USER_EMAIL) ?? '';
  // }
  //
  // String getUserPassword() {
  //   return sharedPreferences.getString(app_constants.USER_PASSWORD) ?? '';
  // }
  //
  // Future<bool> clearUserEmailAndPassword() async {
  //   await sharedPreferences.remove(app_constants.USER_PASSWORD);
  //   final result = await sharedPreferences.remove(app_constants.USER_EMAIL);
  //   return result;
  // }
  //
  // Future<ApiResponse> forgetPassword(String email) async {
  //   try {
  //     final Response response = await dioClient
  //         .post(app_constants.FORGET_PASSWORD_URI, data: {'email': email});
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }
}
