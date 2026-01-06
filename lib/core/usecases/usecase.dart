import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppFailure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class BodyParams extends Equatable {
  final Map<String, dynamic> body;

  const BodyParams({required this.body});

  @override
  List<Object> get props => [body];
}

class StringParams extends Equatable {
  final String body;

  const StringParams({required this.body});

  @override
  List<Object> get props => [body];
}
