import 'package:my_custom_widget/features/notifications/domain/entity/notification.dart';

class NotificationModel extends NotificationInfo {
  NotificationModel(
      {required super.id,
      required super.message,
      required super.subject,
      required super.isRead,
      required super.triggerTypeId,
      required super.triggerId,
      required super.imageUrl,
      required super.creationDate});

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["Id"],
        message: json["Message"],
        subject: json["Subject"],
        isRead: json["IsRead"],
        triggerTypeId: json["TriggerTypeId"],
        triggerId: json["TriggerId"],
        imageUrl: json["ImageUrl"],
        creationDate: DateTime.parse(json["CreationDate"]),
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Message'] = message;
    map['Subject'] = subject;
    map['IsRead'] = isRead;
    map['TriggerTypeId'] = triggerTypeId;
    map['TriggerId'] = triggerId;
    map['ImageUrl'] = imageUrl;
    map["CreationDate"] = creationDate.toIso8601String();
    return map;
  }
}
