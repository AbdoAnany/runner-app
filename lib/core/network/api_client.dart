import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../const/const.dart';
import '../constants/app_constants.dart';
import 'network_info.dart'; // Import your NetworkInfo class if needed

// Custom Exception class to handle API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() {
    return 'ApiException: $message (Status code: $statusCode)';
  }
}

class ApiClient {
  final Dio _dio;
  final NetworkInfo _networkInfo=NetworkInfo();

  ApiClient()
      : _dio = Dio(BaseOptions(
    baseUrl: AppConst.baseUrl, // Replace with your base URL
    connectTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
    headers: {
      'Content-Type': 'application/json',
    },
  )) {
    // Add interceptors for request/response/error handling
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Optionally add token or modify headers here
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle response here, e.g., log the response
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        // Handle errors and convert them into user-friendly messages
        ApiException apiException = _handleError(e);
        return handler.reject(DioError(
          requestOptions: e.requestOptions,
          error: apiException.message,
          response: e.response,
        ));
      },
    ));
  }

  // Centralized error handling
  ApiException _handleError(DioException e) {
    String message = 'Something went wrong';
    int? statusCode;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection Timeout. Please check your internet connection.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send Timeout. Please try again later.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive Timeout. Please try again later.';
        break;
      case DioExceptionType.badResponse:
        statusCode = e.response?.statusCode;
        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              message = 'Bad Request. Please check your input.';
              break;
            case 401:
              message = 'Unauthorized. Please login again.';
              break;
            case 403:
              message = 'Forbidden. You don\'t have permission to access this resource.';
              break;
            case 404:
              message = 'Not Found. The requested resource could not be found.';
              break;
            case 500:
              message = 'Internal Server Error. Please try again later.';
              break;
            default:
              message = 'Received invalid status code: $statusCode';
              break;
          }
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        break;

      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        message = 'Connection to API server failed due to internet connection';
        break;
    }

    return ApiException(message, statusCode: statusCode);
  }

  // Generic request method to handle all types of requests
  Future<Either<ApiException, Response>> request(
      String method, String endpoint, {dynamic data}) async {
    if (!await _networkInfo.isConnected()) {
      return Left(ApiException('No Internet Connection'));
    }

    try {
      final response = await _dio.request(
        endpoint,
        data: data,
        options: Options(method: method),
      );
      return Right(response); // Success
    } catch (e) {
      // Return the ApiException on error
      return Left(ApiException('An error occurred: $e'));
    }
  }

  // Convenience methods for common HTTP methods
  Future<Either<ApiException, Response>> get(String endpoint) => request('GET', endpoint);
  Future<Either<ApiException, Response>> post(String endpoint, dynamic data) => request('POST', endpoint, data: data);
  Future<Either<ApiException, Response>> put(String endpoint, dynamic data) => request('PUT', endpoint, data: data);
  Future<Either<ApiException, Response>> delete(String endpoint) => request('DELETE', endpoint);
}
