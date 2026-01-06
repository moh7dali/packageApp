import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/constants/constants.dart';
import '../../features/main/presentation/getx/main_controller.dart';
import '../../features/notifications/presentation/getx/notifications_controller.dart';
import '../../features/rate/presentation/widgets/rate_widget.dart';
import '../../my_custom_widget.dart';
import '../model/push_notification_model.dart';

bool fromNotification = false;

class OneSignalConfig {
  static onClickedNotification(PushNotificationModel notification) async {
    OneSignal.Notifications.clearAll();
    SharedHelper().closeAllDialogs();
    Get.deleteAll();
    fromPush = true;
    switch (notification.trg) {
      case NotificationTriggerType.addedPoints: // 1 - rate branch
      case NotificationTriggerType.redeemedPoints: // 2 - rate branch
        Get.offAllNamed(RouteConstant.mainPage);
        SharedHelper().scaleDialog(RateWidget(notification: notification));
        break;
      case NotificationTriggerType.newRegistration: // 6 - go to rewards screen
      case NotificationTriggerType.invitation: // 5 - go to rewards screen
      case NotificationTriggerType.addReferral: // 7 - go to rewards screen
      case NotificationTriggerType.redeemReward: // 14 - go to rewards screen
      case NotificationTriggerType.reward: // 3 - go to rewards screen
        Get.offAllNamed(RouteConstant.mainPage);
        Get.put(MainController({'index': 3}));
        break;
      case NotificationTriggerType.system:
        isSystem = true;
        fromPush = false;
        Get.offAllNamed(RouteConstant.splashPage);
        break;
      case NotificationTriggerType.share: // 4 - go to notification center screen
      case NotificationTriggerType.balanceTransferAddition: // 8 - go to notification center screen
      case NotificationTriggerType.balanceTransferSubtraction: // 9 - go to notification center screen
      case NotificationTriggerType.pointExpiry: // 11 - go to notification center screen
      case NotificationTriggerType.migration: // 12 - go to notification center screen
      case NotificationTriggerType.transferTransaction: // 13 - go to notification center screen
      case NotificationTriggerType.orderRedeemPoint: // 15 - go to notification center screen
      case NotificationTriggerType.orderAddPoint: // 16 - go to notification center screen
      case NotificationTriggerType.returnCheckout: // 17 - go to notification center screen
      case NotificationTriggerType.updatePaymentStatus: // 18 - go to notification center screen
      case NotificationTriggerType.promotion: // 19 - go to notification center screen
      case NotificationTriggerType.newOrder: // 20 - go to notification center screen
      case NotificationTriggerType.addedByAdmin: // 21 - go to notification center screen
      case NotificationTriggerType.tierUpgrade: // Tier Upgrade
      default: // - go to notification center screen
        Get.offAllNamed(RouteConstant.mainPage);
        SharedHelper().actionDialog(
          notification.title ?? "",
          notification.body ?? "",
          hasImage: notification.image != null,
          image: notification.image,
          confirm: () {
            SharedHelper().closeAllDialogs();
            Get.toNamed(RouteConstant.notificationsPage);
          },
          confirmText: 'done'.tr,
        );
    }
  }

  static onForegroundNotification(PushNotificationModel notification) async {
    SharedHelper().closeAllDialogs();
    OneSignal.Notifications.clearAll();
    switch (notification.trg) {
      case NotificationTriggerType.addedPoints: // 1 - rate branch
      case NotificationTriggerType.redeemedPoints: // 2 - rate branch
        Map<String, int> pageIndex = {'index': 0};
        Get.deleteAll();
        Get.offAllNamed(RouteConstant.mainPage, arguments: pageIndex);
        SharedHelper().scaleDialog(RateWidget(notification: notification));
        break;
      case NotificationTriggerType.newRegistration: // 6 - go to rewards screen
      case NotificationTriggerType.tierUpgrade: // tier Upgrade
        break;
      case NotificationTriggerType.invitation: // 5 - go to rewards screen
      case NotificationTriggerType.addReferral: // 7 - go to rewards screen
      case NotificationTriggerType.redeemReward: // 14 - go to rewards screen
      case NotificationTriggerType.reward: // 3 - go to rewards screen
        NotificationsController controller;
        if (Get.isRegistered<NotificationsController>()) {
          controller = Get.find<NotificationsController>();
        } else {
          controller = Get.put(NotificationsController());
        }
        controller.getNumOfUnreadNotifications();
        SharedHelper().actionDialog(
          notification.title ?? "",
          notification.body ?? "",
          hasImage: notification.image != null,
          image: notification.image,
          confirm: () {
            SharedHelper().closeAllDialogs();
            Get.offAllNamed(RouteConstant.mainPage);
            Get.put(MainController({'index': 3}));
            // Get.toNamed(RouteConstant.rewardsScreen);
          },
        );
        break;
      case NotificationTriggerType.system:
        NotificationsController controller;
        if (Get.isRegistered<NotificationsController>()) {
          controller = Get.find<NotificationsController>();
        } else {
          controller = Get.put(NotificationsController());
        }
        controller.getNumOfUnreadNotifications();
        SharedHelper().actionDialog(
          notification.title ?? "",
          notification.body ?? "",
          hasImage: notification.image != null,
          image: notification.image,
          noCancel: true,
          confirm: () {
            SharedHelper().closeAllDialogs();
          },
        );
        break;

      case NotificationTriggerType.addedByAdmin: // 21 - go to notification center screen
      case NotificationTriggerType.detectedByAdmin: // 22 - go to notification center screen
        Map<String, int> pageIndex = {'index': 0};
        Get.deleteAll();
        Get.offAllNamed(RouteConstant.mainPage, arguments: pageIndex);
        SharedHelper().actionDialog(
          notification.title ?? "",
          notification.body ?? "",
          hasImage: notification.image != null,
          image: notification.image,
          confirm: () {
            SharedHelper().closeAllDialogs();
            Get.toNamed(RouteConstant.notificationsPage);
          },
          confirmText: 'done'.tr,
        );
        break;

      case NotificationTriggerType.share: // 4 - go to notification center screen
      case NotificationTriggerType.balanceTransferAddition: // 8 - go to notification center screen
      case NotificationTriggerType.balanceTransferSubtraction: // 9 - go to notification center screen
      case NotificationTriggerType.pointExpiry: // 11 - go to notification center screen
      case NotificationTriggerType.migration: // 12 - go to notification center screen
      case NotificationTriggerType.transferTransaction: // 13 - go to notification center screen
      case NotificationTriggerType.orderRedeemPoint: // 15 - go to notification center screen
      case NotificationTriggerType.orderAddPoint: // 16 - go to notification center screen
      case NotificationTriggerType.returnCheckout: // 17 - go to notification center screen
      case NotificationTriggerType.updatePaymentStatus: // 18 - go to notification center screen
      case NotificationTriggerType.promotion: // 19 - go to notification center screen
      case NotificationTriggerType.newOrder: // 20 - go to notification center screen
      default: // - go to notification center screen
        NotificationsController controller;
        if (Get.isRegistered<NotificationsController>()) {
          controller = Get.find<NotificationsController>();
        } else {
          controller = Get.put(NotificationsController());
        }
        controller.getNumOfUnreadNotifications();
        SharedHelper().actionDialog(
          notification.title ?? "",
          notification.body ?? "",
          hasImage: notification.image != null,
          image: notification.image,
          confirm: () {
            SharedHelper().closeAllDialogs();
            Get.toNamed(RouteConstant.notificationsPage);
          },
          confirmText: 'done'.tr,
        );
        break;
    }
  }
}
