import '../../domain/entities/customer_data.dart';
import 'customer_info_model.dart';
import 'customer_loyalty_data_model.dart';

class CustomerDataModel extends CustomerData {
  const CustomerDataModel({required super.customerInfo, required super.customerLoyaltyData, required super.unreadNotificationCount});

  factory CustomerDataModel.fromJson(Map<String, dynamic> json) => CustomerDataModel(
        customerLoyaltyData: json["CustomerLoyaltyData"] == null ? null : CustomerLoyaltyDataModel.fromMap(json["CustomerLoyaltyData"]),
        customerInfo: json["CustomerInfo"] == null ? null : CustomerInfoModel.fromMap(json["CustomerInfo"]),
        unreadNotificationCount: json["UnreadNotificationCount"],
      );

  Map<String, dynamic> toMap() => {
        "CustomerLoyaltyData": customerLoyaltyData,
        "CustomerInfo": customerInfo,
        "UnreadNotificationCount": unreadNotificationCount,
      };
}
