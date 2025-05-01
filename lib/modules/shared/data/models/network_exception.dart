import 'package:dio/dio.dart';

class NetworkException extends DioException {
  NetworkException({required DioException originalException})
      : super(
          requestOptions: originalException.requestOptions,
          error: originalException.error,
          message: originalException.message,
          response: originalException.response,
          stackTrace: originalException.stackTrace,
          type: originalException.type,
        );
}
