import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/core/usecases/usecase.dart';
import 'package:mozaic_loyalty_sdk/features/barcode/domain/entities/user_barcode.dart';
import 'package:mozaic_loyalty_sdk/features/barcode/domain/repositories/user_barcode_repository.dart';

import '../../../../core/error/failures.dart';

class GetUserBarcode implements UseCase<UserBarcode, NoParams> {
  final UserBarcodeRepository repository;

  GetUserBarcode(this.repository);

  @override
  Future<Either<AppFailure, UserBarcode>> call(NoParams params) async {
    return await repository.getUserBarcode();
  }
}
