import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/app_log.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/no_item_widget.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../domain/entity/notification.dart';
import '../getx/notifications_controller.dart';
import '../widgets/notification_card_loading.dart';
import '../widgets/notification_card_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      init: NotificationsController(),
      builder: (controller) {
        var oneSignalToken = OneSignal.User.pushSubscription.id;
        appLog(oneSignalToken, tag: "userPushSubscription");
        return Scaffold(
          appBar: AppBar(
            title: Text("notifications".tr),
            actions: [
              TextButton(
                onPressed: () {
                  controller.setReadNotification();
                },
                child: Text(
                  "readAll".tr,
                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                ),
              ),
            ],
          ),
          body: controller.isLoading
              ? ListView.builder(
            itemCount: 4,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            itemBuilder: (context, index) => const NotificationCardLoading(),
          )
              : PaginationListView<NotificationInfo>(
            loadFirstList: () async => await controller.getUserNotification(page: 1),
            loadMoreList: (page) async => controller.getUserNotification(page: page),
            itemBuilder: (context, value) => NotificationCardWidget(
              notification: value,
              onTap: () async {
                if (value.isRead == false) {
                  await controller.setReadNotification(notification: value);
                }
                controller.handelClick(value.triggerTypeId);
              },
            ),
            emptyWidget: NoItemWidget(),
            emptyText: "notificationEmpty".tr,
            loadingWidget: const NotificationCardLoading(),
          ),

        );
      },
    );
  }
}
