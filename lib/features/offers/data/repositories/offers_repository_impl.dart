import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/offers/data/datasources/offers_api_datasource.dart';
import 'package:my_custom_widget/features/offers/domain/entity/offers_list.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/offers_repository.dart';

class OffersRepositoryImpl implements OffersRepository {
  final OffersApiDataSource remoteDataSource;

  OffersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, OffersList>> getOffers({Map<String, dynamic>? body}) async {
    try {
      final offersList = await remoteDataSource.getOffers(body: body!);
      return Right(offersList);
    } on ApiErrorsException catch (e) {
      return Left(
        AppFailure(
          errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage),
          failureType: FailureType.serverFailure,
        ),
      );
    }
  }
}
