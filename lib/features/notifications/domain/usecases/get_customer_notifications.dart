import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:my_custom_widget/features/notifications/domain/repositories/notification_repository.dart';

import '../../../../core/error/failures.dart';
import '../entity/notification_list.dart';

class GetCustomerNotifications implements UseCase<NotificationList, BodyParams> {
  final NotificationsRepositories repository;

  GetCustomerNotifications(this.repository);

  @override
  Future<Either<AppFailure, NotificationList>> call(BodyParams params) async {
    return await repository.getCustomerNotifications(body: params.body);
  }
}
