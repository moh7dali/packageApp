import 'package:get/get.dart';
import 'package:my_custom_widget/features/notifications/domain/entity/notification.dart';
import 'package:my_custom_widget/features/notifications/domain/usecases/change_notifications_read_status.dart';
import 'package:my_custom_widget/features/notifications/domain/usecases/get_customer_notifications.dart';
import 'package:my_custom_widget/my_custom_widget.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/app_log.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/usecases/get_number_of_unread_notifications.dart';

class NotificationsController extends GetxController {
  final GetCustomerNotifications getCustomerNotifications;
  final ChangeNotificationsReadStatus changeNotificationsReadStatus;
  final GetNumberOfUnreadNotifications getNumberOfUnreadNotifications;

  NotificationsController() : getCustomerNotifications = sl(), changeNotificationsReadStatus = sl(), getNumberOfUnreadNotifications = sl();

  List<NotificationInfo> userNotificationList = [];
  bool isLoading = false;

  Future<PaginationListModel> getUserNotification({int page = 1}) async {
    userNotificationList = [];
    int totalNumberOfResult = 0;
    await getCustomerNotifications.repository
        .getCustomerNotifications(body: {"pageNumber": "$page"})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (notificationsList) {
              List<NotificationInfo> notificationForSize = notificationsList.notifications ?? [];
              userNotificationList = notificationForSize;
              totalNumberOfResult = notificationsList.totalNumberOfResult ?? 0;
              update();
            },
          ),
        );
    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: userNotificationList);
  }

  setReadNotification({NotificationInfo? notification}) async {
    SharedHelper().scaleDialog(const LoadingWidget(), dismissible: false);
    update();
    await changeNotificationsReadStatus.repository
        .changeNotificationsReadStatus(body: notification == null ? {} : {"notificationId": "${notification.id}"})
        .then(
          (value) => value.fold(
            (failure) {
              SDKNav.back();
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (r) async {
              if (notification != null) {
                notification.isRead = true;
                update();
              } else {
                isLoading = true;
                update();
                Future.delayed(Duration(seconds: 1), () {
                  isLoading = false;
                  update();
                });
                // await getUserNotification();
              }
              getNumOfUnreadNotifications();
              SharedHelper().closeAllDialogs();
              update();
            },
          ),
        );
  }

  getNumOfUnreadNotifications() async {
    await getNumberOfUnreadNotifications.repository.getNumberOfUnreadNotifications().then(
      (value) => value.fold(
        (failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        },
        (numberOfNotifications) {
          numOfUnReadNotifications.value = numberOfNotifications;
          update();
        },
      ),
    );
  }

  handelClick(int trigId) {
    appLog("handelClick: $trigId");
    switch (trigId) {
      case NotificationTriggerType.addedPoints: // 1 - rate branch
      case NotificationTriggerType.redeemedPoints: // 2 - rate branch
      case NotificationTriggerType.share: // 4 - go to notification center screen
      case NotificationTriggerType.invitation: // 5 - go to notification center screen
      case NotificationTriggerType.balanceTransferAddition: // 8 - go to notification center screen
      case NotificationTriggerType.balanceTransferSubtraction: // 9 - go to notification center screen
      case NotificationTriggerType.pointExpiry: // 11 - go to notification center screen
      case NotificationTriggerType.addedByAdmin: // 21 - go to notification center screen
      case NotificationTriggerType.detectedByAdmin: // 21 - go to notification center screen
      case NotificationTriggerType.migration: // 12 - go to notification center screen
        Map<String, int> pageIndex = {'index': 1};
        Get.deleteAll();
        SDKNav.offAllNamed(RouteConstant.mainPage, arguments: pageIndex);
        break;
      case NotificationTriggerType.reward: // 3 - go to rewards screen
      case NotificationTriggerType.newRegistration: // 6 - go to rewards screen
      case NotificationTriggerType.addReferral: // 7 - go to rewards screen
      case NotificationTriggerType.redeemReward: // 14 - go to rewards screen
        Map<String, int> pageIndex = {'index': 3};
        Get.deleteAll();
        SDKNav.offAllNamed(RouteConstant.mainPage, arguments: pageIndex);
        break;

      case NotificationTriggerType.system: // 10 - go to notification center screen
      case NotificationTriggerType.transferTransaction: // 13 - go to notification center screen
      case NotificationTriggerType.orderRedeemPoint: // 15 - go to notification center screen
      case NotificationTriggerType.orderAddPoint: // 16 - go to notification center screen
      case NotificationTriggerType.returnCheckout: // 17 - go to notification center screen
      case NotificationTriggerType.updatePaymentStatus: // 18 - go to notification center screen
      case NotificationTriggerType.promotion: // 19 - go to notification center screen
      case NotificationTriggerType.newOrder: // 20 - go to notification center screen
      default: // - go to notification center screen
        break;
    }
  }
}
