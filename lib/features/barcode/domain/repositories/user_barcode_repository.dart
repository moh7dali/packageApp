import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/barcode/data/models/user_barcode_model.dart';

import '../../../../core/error/failures.dart';

abstract class UserBarcodeRepository {
  Future<Either<AppFailure, UserBarcodeModel>> getUserBarcode();
}
