import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/request/auth_request.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/base/error_response.dart';
import 'package:template/data/model/response/response_model.dart';
import 'package:template/data/repository/auth_repository.dart';
import 'package:template/helper/api_checker.dart';

class AuthProvider with ChangeNotifier {
  AuthRepository? authRepository = GetIt.I.get<AuthRepository>();

  AuthProvider();

  ///
  /// login
  ///
  Future<void> login({
    required AuthRequest request,
    required Function(AuthModel auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.login(request);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final AuthModel authResponse =
          AuthModel.fromJson(results['user'] as Map<String, dynamic>);
      authResponse.access = results['tokens']['access']['token'].toString();
      authResponse.refresh = results['tokens']['refresh']['token'].toString();
      onSuccess(authResponse);
    } else {
      onError(apiResponse.error);
    }
  }
}
