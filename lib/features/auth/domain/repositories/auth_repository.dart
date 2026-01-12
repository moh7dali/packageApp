import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/auth/domain/entities/check_validation_code.dart';

import '../../../../core/error/failures.dart';
import '../entities/countries_list.dart';
import '../entities/verify_mobile_number.dart';

abstract class AuthRepositories {
  Future<Either<AppFailure, VerifyMobileNumber>> postVerifyMobileNumber({Map<String, dynamic>? body});

  Future<Either<AppFailure, CheckValidationCode>> postCheckValidationCode({Map<String, dynamic>? body});

  Future<Either<AppFailure, dynamic>> postCompleteProfile({Map<String, dynamic>? body});

  Future<Either<AppFailure, bool>> resendVerificationCode();

  Future<Either<AppFailure, dynamic>> addReferral({Map<String, dynamic>? body});

  Future<Either<AppFailure, CountriesList>> getCountries({Map<String, dynamic>? body});
}
