import 'package:equatable/equatable.dart';

class NotificationInfo extends Equatable {
  final int id;
  final String message;
  final String subject;
  bool isRead;
  final int triggerTypeId;
  final dynamic triggerId;
  final dynamic imageUrl;
  final DateTime creationDate;

  NotificationInfo(
      {required this.id,
      required this.message,
      required this.subject,
      required this.isRead,
      required this.triggerTypeId,
      required this.triggerId,
      required this.imageUrl,
      required this.creationDate});

  @override
  List<Object?> get props => [
        id,
        message,
        subject,
        isRead,
        triggerTypeId,
        triggerId,
        imageUrl,
        creationDate,
      ];
}
