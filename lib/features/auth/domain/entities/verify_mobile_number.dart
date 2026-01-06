import 'package:equatable/equatable.dart';

class VerifyMobileNumber extends Equatable {
  final String token;

  const VerifyMobileNumber({required this.token});

  @override
  List<Object?> get props => [token];
}
