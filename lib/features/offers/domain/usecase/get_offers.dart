import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/offers/domain/entity/offers_list.dart';
import 'package:my_custom_widget/features/offers/domain/repositories/offers_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetAllOffers implements UseCase<OffersList?, BodyParams> {
  final OffersRepository repository;

  GetAllOffers(this.repository);

  @override
  Future<Either<AppFailure, OffersList?>> call(BodyParams params) async {
    return await repository.getOffers(body: params.body);
  }
}
