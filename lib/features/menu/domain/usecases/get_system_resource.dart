import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/menu/domain/entity/invite_friend.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/menu_repository.dart';

class GetSystemResource implements UseCase<InviteFriends, BodyParams> {
  final MenuRepositories repository;

  GetSystemResource(this.repository);

  @override
  Future<Either<AppFailure, InviteFriends>> call(BodyParams params) async {
    return await repository.getSystemResource(body: params.body);
  }
}
