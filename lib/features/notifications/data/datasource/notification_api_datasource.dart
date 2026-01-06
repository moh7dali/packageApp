import 'package:my_custom_widget/core/api/api_response.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entity/notification_list.dart';
import '../models/notification_list_model.dart';

abstract class NotificationsApiDataSource {
  Future<NotificationList> getCustomerNotifications({required Map<String, dynamic> body});

  Future<dynamic> changeNotificationsReadStatus({Map<String, dynamic>? body});

  Future<int> getNumberOfUnreadNotifications();
}

class NotificationsApiDataSourceImpl implements NotificationsApiDataSource {
  @override
  Future<NotificationList> getCustomerNotifications({required Map<String, dynamic> body}) async {
    NotificationList notificationList = await ApiRequest<NotificationList>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getNotifications,
      body: {},
      queryParameters: body,
      authorized: true,
      fromJson: NotificationListModel.fromJson,
    );
    return notificationList;
  }

  @override
  Future<dynamic> changeNotificationsReadStatus({Map<String, dynamic>? body}) async {
    dynamic changeNotificationsReadStatus = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.changeNotificationsReadStatus,
      body: {},
      queryParameters: body,
      authorized: true,
      fromJson: getDynamic,
    );
    return changeNotificationsReadStatus;
  }

  @override
  Future<int> getNumberOfUnreadNotifications() async {
    int numberOfUnreadNotifications = await ApiRequest<int>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getNumberOfNotifications,
      body: {},
      authorized: true,
      fromJson: getInt,
    );
    return numberOfUnreadNotifications;
  }
}
