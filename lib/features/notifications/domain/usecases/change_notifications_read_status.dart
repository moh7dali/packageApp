import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

class ChangeNotificationsReadStatus implements UseCase<dynamic, BodyParams> {
  final NotificationsRepositories repository;

  ChangeNotificationsReadStatus(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(BodyParams params) async {
    return await repository.changeNotificationsReadStatus(body: params.body);
  }
}
