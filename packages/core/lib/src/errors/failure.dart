import 'package:equatable/equatable.dart';
import 'package:core/src/errors/error_code.dart';

class Failure extends Equatable {
  const Failure(this.code, this.message, {this.stackTrace});

  final int code;
  final String message;
  final StackTrace? stackTrace;

  factory Failure.unidentified({String? message, StackTrace? stackTrace}) =>
      Failure(ErrorCode.unidentified, message ?? 'เกิดข้อผิดพลาดที่ไม่ได้ระบุ', stackTrace: stackTrace);

  factory Failure.connectionTimeout({String? message, StackTrace? stackTrace}) =>
      Failure(ErrorCode.connectionTimeout, message ?? 'หมดเวลาการเชื่อมต่อกับเซิฟเวอร์', stackTrace: stackTrace);

  factory Failure.connectionError({String? message, StackTrace? stackTrace}) =>
      Failure(ErrorCode.connectionError, message ?? 'เกิดข้อผิดพลาดในการเชื่อมต่อเซิฟเวอร์', stackTrace: stackTrace);

  factory Failure.receiveTimeout({String? message, StackTrace? stackTrace}) =>
      Failure(ErrorCode.receiveTimeout, message ?? 'หมดเวลาการรับข้อมูลจากเซิฟเวอร์', stackTrace: stackTrace);

  factory Failure.sendTimeout({String? message, StackTrace? stackTrace}) =>
      Failure(ErrorCode.sendTimeout, message ?? 'หมดเวลาการส่งข้อมูลไปยังเซิฟเวอร์', stackTrace: stackTrace);

  factory Failure.cancelled({String? message, StackTrace? stackTrace}) =>
      Failure(ErrorCode.cancelled, message ?? 'ถูกยกเลิกคำร้องขอจากเซิฟเวอร์', stackTrace: stackTrace);

  factory Failure.localStorageError({String? message, StackTrace? stackTrace}) => Failure(
    ErrorCode.localStorageError,
    message ?? 'เกิดข้อผิดพลาดในการจัดการข้อมูลในเครื่อง',
    stackTrace: stackTrace,
  );

  factory Failure.noInternetConnection({String? message, StackTrace? stackTrace}) => Failure(
    ErrorCode.noInternetConnection,
    message ?? 'ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้ กรุณาตรวจสอบการเชื่อมต่อของคุณ',
    stackTrace: stackTrace,
  );

  factory Failure.dataParsingError({String? message, StackTrace? stackTrace}) =>
      Failure(ErrorCode.dataParsingError, message ?? 'เกิดข้อผิดพลาดในการประมวลผลข้อมูล', stackTrace: stackTrace);

  /// Check if this is a network-related error
  bool get isNetworkError => code >= 1001 && code <= 1007;

  /// Check if this is a validation error
  bool get isValidationError => code == 400 || code == 422;

  /// Check if this is a server error
  bool get isServerError => code >= 500 && code < 600;

  @override
  List<Object?> get props => [code, message, stackTrace];

  @override
  String toString() {
    return 'Failure(code: $code, message: $message)';
  }
}
