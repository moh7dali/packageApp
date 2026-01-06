import 'package:equatable/equatable.dart';

import 'customer_info.dart';
import 'customer_loyalty_data.dart';

class CustomerData extends Equatable {
  final CustomerLoyaltyData? customerLoyaltyData;
  final CustomerInfo? customerInfo;
  final int? unreadNotificationCount;

  const CustomerData({
    this.customerLoyaltyData,
    this.customerInfo,
    this.unreadNotificationCount,
  });

  @override
  List<Object?> get props => [customerLoyaltyData, customerInfo, unreadNotificationCount];
}
