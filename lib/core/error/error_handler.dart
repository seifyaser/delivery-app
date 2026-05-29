import 'package:dio/dio.dart';
import 'failures.dart';
import 'error_model.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else {
      return const UnknownFailure();
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return const UnauthorizedFailure();
        }
        if (error.response?.data != null) {
          try {
            final errorModel = ErrorModel.fromJson(error.response!.data is Map ? error.response!.data : {});
            return ServerFailure(errorModel.message);
          } catch (_) {
            return const ServerFailure();
          }
        }
        return const ServerFailure();
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
      default:
        return const UnknownFailure();
    }
  }
}
