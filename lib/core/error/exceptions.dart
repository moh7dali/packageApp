import 'package:equatable/equatable.dart';

class ApiErrorsException extends Equatable implements Exception {
  final String? errorMessage;
  final String? errorCode;

  const ApiErrorsException({required this.errorCode, required this.errorMessage});

  @override
  List<Object?> get props => [
        errorMessage,
        errorCode,
      ];
}

class CacheException implements Exception {}
