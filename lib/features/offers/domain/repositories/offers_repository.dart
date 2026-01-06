import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/offers/domain/entity/offers_list.dart';

import '../../../../core/error/failures.dart';

abstract class OffersRepository {
  Future<Either<AppFailure, OffersList>> getOffers({Map<String, dynamic>? body});
}
