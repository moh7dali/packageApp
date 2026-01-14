import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/features/barcode/data/models/user_barcode_model.dart';

import '../../../../core/error/failures.dart';

abstract class UserBarcodeRepository {
  Future<Either<AppFailure, UserBarcodeModel>> getUserBarcode();
}
