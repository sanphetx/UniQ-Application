import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:core/src/errors/exception.dart';

import 'failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  static Future<Either<Failure, T>> handle<T>(Future<T> Function() function) async {
    try {
      final result = await function();
      return Right(result);
    } catch (error, stackTrace) {
      developer.log('Error occurred: ${error.toString()}', name: 'ErrorHandler', error: error, stackTrace: stackTrace);

      // Handle specific error types first
      if (error is DioException) {
        return Left(_handleDioError(error, stackTrace));
      }

      if (error is SocketException) {
        return Left(Failure.noInternetConnection(stackTrace: stackTrace));
      }

      if (error is FormatException) {
        return Left(Failure.dataParsingError(stackTrace: stackTrace));
      }

      if (error is HiveError || error is LocalStorageException) {
        return Left(Failure.localStorageError(stackTrace: stackTrace));
      }

      return Left(Failure.unidentified(stackTrace: stackTrace));
    }
  }

  static Failure _handleDioError(DioException error, StackTrace? stackTrace) {
    switch (error.type) {
      case DioExceptionType.receiveTimeout:
        return Failure.receiveTimeout(stackTrace: stackTrace);

      case DioExceptionType.sendTimeout:
        return Failure.sendTimeout(stackTrace: stackTrace);

      case DioExceptionType.connectionTimeout:
        return Failure.connectionTimeout(stackTrace: stackTrace);

      case DioExceptionType.connectionError:
        return Failure.connectionError(stackTrace: stackTrace);

      case DioExceptionType.cancel:
        return Failure.cancelled(stackTrace: stackTrace);

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response, stackTrace);

      default:
        return Failure.unidentified(stackTrace: stackTrace);
    }
  }

  static Failure _handleBadResponse(Response? response, StackTrace? stackTrace) {
    if (response == null) {
      return Failure(
        HttpStatus.internalServerError,
        _getDefaultMessageForStatusCode(HttpStatus.internalServerError),
        stackTrace: stackTrace,
      );
    }

    final statusCode = response.statusCode ?? HttpStatus.internalServerError;
    String message = _getDefaultMessageForStatusCode(statusCode);
    int code = statusCode;

    // Try to extract custom message and code from response
    final data = response.data;
    if (data is Map<String, dynamic>) {
      // Extract custom message
      final customMessage = _extractMessage(data);
      if (customMessage != null) {
        message = customMessage;
      }

      // Extract custom code
      final customCode = _extractStatusCode(data);
      if (customCode != null) {
        code = customCode;
      }
    }

    return Failure(code, message, stackTrace: stackTrace);
  }

  static String _getDefaultMessageForStatusCode(int statusCode) {
    switch (statusCode) {
      case HttpStatus.badRequest:
        return 'ข้อมูลที่ส่งไม่ถูกต้อง';
      case HttpStatus.unauthorized:
        return 'ไม่มีสิทธิ์เข้าใช้งาน กรุณาเข้าสู่ระบบใหม่';
      case HttpStatus.forbidden:
        return 'ไม่มีสิทธิ์ในการดำเนินการนี้';
      case HttpStatus.notFound:
        return 'ไม่พบข้อมูลที่ต้องการ';
      case HttpStatus.conflict:
        return 'ข้อมูลมีความขัดแย้ง';
      case HttpStatus.unprocessableEntity:
        return 'ข้อมูลไม่สามารถประมวลผลได้';
      case HttpStatus.tooManyRequests:
        return 'มีการร้องขอมากเกินไป กรุณาลองใหม่ในภายหลัง';
      case HttpStatus.internalServerError:
        return 'เกิดข้อผิดพลาดภายในเซิร์ฟเวอร์';
      case HttpStatus.badGateway:
        return 'เซิร์ฟเวอร์ไม่สามารถเชื่อมต่อได้';
      case HttpStatus.serviceUnavailable:
        return 'บริการไม่พร้อมใช้งานในขณะนี้';
      case HttpStatus.gatewayTimeout:
        return 'เซิร์ฟเวอร์ตอบสนองช้าเกินไป';
      default:
        return 'เกิดข้อผิดพลาดจากเซิร์ฟเวอร์ (รหัส: $statusCode)';
    }
  }

  static String? _extractMessage(Map<String, dynamic> data) {
    // Try different common message fields
    final messageFields = ['message', 'error', 'detail', 'description'];

    for (final field in messageFields) {
      final value = data[field];
      if (value is String && value.isNotEmpty) {
        return value;
      }
    }

    return null;
  }

  static int? _extractStatusCode(Map<String, dynamic> data) {
    // Try different common status code fields
    final statusCodeFields = ['code', 'statusCode', 'status_code', 'error_code'];

    for (final field in statusCodeFields) {
      final value = data[field];
      if (value is int) {
        return value;
      }

      if (value is String && value.isNotEmpty) {
        return int.tryParse(value);
      }
    }

    return null;
  }
}
