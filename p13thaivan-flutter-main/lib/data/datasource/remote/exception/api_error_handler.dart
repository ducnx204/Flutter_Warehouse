import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/base/error_response.dart';

class ApiErrorHandler {
  static dynamic getMessage(dynamic error) {
    dynamic errorDescription = '';
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = 'Request to API server was cancelled';
              break;
            case DioErrorType.connectTimeout:
              errorDescription = 'Connection timeout with API server';
              break;
            case DioErrorType.other:
              errorDescription =
                  'Connection to API server failed due to internet connection';
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
                  'Receive timeout in connection with API server';
              break;
            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case 404:
                case 500:
                case 503:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  final Errors errors = Errors.fromJson(error.response!.data);
                  if (errors.message != '') {
                    errorDescription = errors.message;
                  } else {
                    errorDescription =
                        'Failed to load data - status code: ${error.response!.statusCode}';
                  }
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = 'Send timeout with server';
              break;
          }
        } else {
          errorDescription = 'Unexpected error occured';
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = 'is not a subtype of exception';
    }

    // show errors
    Get.snackbar(
      "Hey i'm a Errors SnackBar!", // title
      errorDescription.toString(), // message
      icon: const Icon(Icons.error_outline),
      backgroundColor: Color(0xffFFCDD2),
      shouldIconPulse: true,
      isDismissible: true,
      duration: const Duration(seconds: 3),
    );
    return errorDescription;
  }
}
