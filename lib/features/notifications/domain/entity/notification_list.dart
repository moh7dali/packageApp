import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/notifications/domain/entity/notification.dart';

class NotificationList extends Equatable {
  final List<NotificationInfo>? notifications;
  final int totalNumberOfResult;

  const NotificationList({required this.notifications, required this.totalNumberOfResult});

  @override
  List<Object?> get props => [notifications, totalNumberOfResult];
}
