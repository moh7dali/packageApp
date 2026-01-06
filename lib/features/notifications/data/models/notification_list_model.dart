import 'dart:convert';

import 'package:my_custom_widget/features/notifications/domain/entity/notification.dart';
import 'package:my_custom_widget/features/notifications/domain/entity/notification_list.dart';

import 'notification_model.dart';

NotificationList notificationModelListFromMap(String str) => NotificationListModel.fromJson(json.decode(str));

class NotificationListModel extends NotificationList {
  const NotificationListModel({required super.notifications, required super.totalNumberOfResult});

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
        totalNumberOfResult: json["TotalNumberofResult"],
        notifications:
            json["Notifications"] != null ? List<NotificationInfo>.from(json["Notifications"].map((x) => NotificationModel.fromJson(x))) : null,
      );
}
