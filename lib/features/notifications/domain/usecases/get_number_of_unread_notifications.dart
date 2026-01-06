import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

class GetNumberOfUnreadNotifications implements UseCase<int, NoParams> {
  final NotificationsRepositories repository;

  GetNumberOfUnreadNotifications(this.repository);

  @override
  Future<Either<AppFailure, int>> call(NoParams params) async {
    return await repository.getNumberOfUnreadNotifications();
  }
}
