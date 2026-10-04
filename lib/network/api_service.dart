
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pabulum_teacher/network/connectivity_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/app_strings.dart';
import 'package:pabulum_teacher/utils/constants.dart';
import 'package:pabulum_teacher/utils/utils.dart';


class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppEndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
    ),
  );

  final ConnectivityService _connectivityService = ConnectivityService();

  Future<Response> getRequest(String endpoint) async {
    bool isConnected = await _connectivityService.hasInternetConnection();
    if (!isConnected) {
      debugPrint("API Request failed: No internet connection for $endpoint");
      //navigateToNoIntertnet();
      Utils.showToast('No Internet Connection', false);
    }
    try {
      debugPrint(AppEndPoints.baseUrl);
      debugPrint(endpoint);
      dynamic header = {
        'content-Type': 'application/json',
      };
      if (Constants.shared.userLoginData != null) {
        var token = Constants.shared.userLoginData?.token;
        header["Authorization"] = "Bearer $token";
      }
      debugPrint(header.toString());
      Response response =
          await _dio.get(endpoint, options: Options(headers: header));
      debugPrint(response.data.toString());
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      return _handleError(e);
    }
  }

  Future<Response> postRequest(String endpoint, dynamic data) async {
    bool isConnected = await _connectivityService.hasInternetConnection();

    if (!isConnected) {
      debugPrint("API Request failed: No internet connection for $endpoint");
      //navigateToNoIntertnet();
      Utils.showToast('No Internet Connection', false);
      // throw NoInternetException(AppStrings.noInternetMsg);
    }
    try {
      dynamic header = {
        'content-Type': 'application/json',
      };
      if (Constants.shared.userLoginData != null) {
        var token = Constants.shared.userLoginData?.token;
        header["Authorization"] = "Bearer $token";
      }
      debugPrint(endpoint.toString());
      debugPrint(data.toString());
      debugPrint(header.toString());

      Response response = await _dio.post(endpoint,
          data: data, options: Options(headers: header));
      debugPrint(response.toString());
      return response;
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      return _handleError(e);
    }
  }

  Future<Response> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    bool isConnected = await _connectivityService.hasInternetConnection();
    if (!isConnected) {
      debugPrint("API Request failed: No internet connection for $endpoint");
      //navigateToNoIntertnet();
      Utils.showToast('No Internet Connection', false);
      //throw NoInternetException(AppStrings.noInternetMsg);
    }

    try {
      dynamic header = {
        'content-Type': 'application/json',
      };
      if (Constants.shared.userLoginData != null) {
        var token = Constants.shared.userLoginData?.token;
        header["Authorization"] = "Bearer $token";
      }
      debugPrint(endpoint.toString());
      debugPrint(data.toString());
      debugPrint(header.toString());

      Response response = await _dio.put(endpoint,
          data: data, options: Options(headers: header));
      debugPrint(response.toString());
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      return _handleError(e);
    }
  }

  Future<Response> deleteRequest(String endpoint) async {
    bool isConnected = await _connectivityService.hasInternetConnection();
    if (!isConnected) {
      debugPrint("API Request failed: No internet connection for $endpoint");
      //navigateToNoIntertnet();
      Utils.showToast('No Internet Connection', false);
      //throw NoInternetException(AppStrings.noInternetMsg);
    }
    try {
      dynamic header = {
        'content-Type': 'application/json',
      };
      if (Constants.shared.userLoginData != null) {
        var token = Constants.shared.userLoginData?.token;
        header["Authorization"] = "Bearer $token";
      }
      debugPrint(endpoint);
      debugPrint(header.toString());

      Response response =
          await _dio.delete(endpoint, options: Options(headers: header));
      debugPrint(response.toString());
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      return _handleError(e);
    }
  }

  Future<Response> multiPartPostRequest(String endpoint, formData) async {
    bool isConnected = await _connectivityService.hasInternetConnection();
    if (!isConnected) {
      debugPrint("API Request failed: No internet connection for $endpoint");
      //navigateToNoIntertnet();
      Utils.showToast('No Internet Connection', false);
      //   throw NoInternetException(AppStrings.noInternetMsg);
    }
    try {
      dynamic header = {'content-Type': 'application/json'};
      if (Constants.shared.userLoginData != null) {
        var token = Constants.shared.userLoginData?.token;
        header["Authorization"] = "Bearer $token";
      }
      debugPrint(header.toString());
      debugPrint(formData.toString());
      debugPrint(endpoint.toString());
      Response response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(headers: header),
      );

      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      return _handleError(e);
    }
  }

  Future<Response> _handleError(DioException error) async {
    debugPrint(error.toString());
    String errorMessage = "";
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = AppStrings.connectionTimeoutMsg;
        break;
      case DioExceptionType.sendTimeout:
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = AppStrings.receiveTimeoutMsg;
        break;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 409 ||
            error.response?.statusCode == 400 ||
            error.response?.statusCode == 404) {
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            errorMessage = data["errorMessage"]?.toString() ??
                data["message"]?.toString() ??
                AppStrings.somethingWantWrong;
          } else if (data is String) {
            errorMessage = data;
          } else {
            errorMessage = AppStrings.somethingWantWrong;
          }
        } else if (error.response?.statusCode == 401) {
          errorMessage = AppStrings.authenticationFailed;
         // navigateToLoginScreen(errorMessage);
        } else {
          errorMessage = AppStrings.invalidStatusCodeMsg +
              error.response!.statusCode.toString();
        }
        break;
      case DioExceptionType.cancel:
        errorMessage = AppStrings.requestCancelled;
        break;
      case DioExceptionType.unknown:
        errorMessage = AppStrings.connectionIssueMsg;
        break;
      case DioExceptionType.badCertificate:
        errorMessage = AppStrings.somethingWantWrong;
        break;
      default:
        errorMessage = AppStrings.somethingWantWrong;
        break;
    }

    return Response(
      requestOptions: error.requestOptions,
      statusCode: error.response?.statusCode ?? 500,
      statusMessage: errorMessage,
    );
  }


}
