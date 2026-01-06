import 'package:my_custom_widget/features/topup/domain/entities/top_up_list.dart';
import 'package:my_custom_widget/features/topup/domain/repositories/top_up_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetTopUp implements UseCase<TopUpList?, BodyParams> {
  final TopUpRepository repository;

  GetTopUp(this.repository);

  @override
  Future<Either<AppFailure, TopUpList?>> call(BodyParams params) async {
    return await repository.getTopUp(body: params.body);
  }
}
