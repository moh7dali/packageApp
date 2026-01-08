import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/menu/domain/entity/merchant_info.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/menu_repository.dart';

class GetMerchantContactInfo implements UseCase<MerchantInfo, BodyParams> {
  final MenuRepositories repository;

  GetMerchantContactInfo(this.repository);

  @override
  Future<Either<AppFailure, MerchantInfo>> call(BodyParams params) async {
    return await repository.getMerchantContactInfo(body: params.body);
  }
}
