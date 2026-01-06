import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/notification_list.dart';

abstract class NotificationsRepositories {
  Future<Either<AppFailure, NotificationList>> getCustomerNotifications({Map<String, dynamic>? body});

  Future<Either<AppFailure, dynamic>> changeNotificationsReadStatus({Map<String, dynamic>? body});

  Future<Either<AppFailure, int>> getNumberOfUnreadNotifications();
}
