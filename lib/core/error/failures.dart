import 'package:equatable/equatable.dart';

import '../api/api_response_error.dart';

class AppFailure extends Equatable {
  final ErrorsModel errorsModel;
  final FailureType failureType;

  const AppFailure({required this.errorsModel, required this.failureType});

  @override
  List<Object> get props => [errorsModel, failureType];
}

enum FailureType {
  serverFailure,
  connectionFailure,
  cacheFailure,
}
