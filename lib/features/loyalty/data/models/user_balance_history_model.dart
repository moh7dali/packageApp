import 'package:my_custom_widget/features/loyalty/domain/entity/user_balance_history.dart';

class UserBalanceHistoryModel extends UserBalanceHistory {
  const UserBalanceHistoryModel(
      {required super.numberOfPoints,
      required super.creationDate,
      required super.expiryDate,
      required super.triggerType,
      required super.source,
      required super.brandName,
      required super.branchName,
      required super.triggerActionName,
      required super.currentStatus,
      required super.activationDate,
      required super.senderName,
      required super.receiverMobileNumber});

  factory UserBalanceHistoryModel.fromJson(Map<String, dynamic> json) => UserBalanceHistoryModel(
        numberOfPoints: json['NumberOfPoints'],
        creationDate: json['CreationDate'],
        expiryDate: json['ExpiryDate'],
        triggerType: json['TriggerType'],
        source: json['Source'],
        currentStatus: json['CurrentStatus'],
        activationDate: json['ActivationDate'],
        senderName: json['SenderName'],
        receiverMobileNumber: json['ReceiverMobileNumber'],
        brandName: json['BrandName'],
        branchName: json['BranchName'],
        triggerActionName: json['TriggerActionName'],
      );

  Map<String, dynamic> toMap() => {
        "NumberOfPoints": numberOfPoints,
        "CreationDate": creationDate,
        "ExpiryDate": expiryDate,
        "TriggerType": triggerType,
        "Source": source,
        "CurrentStatus": currentStatus,
        "ActivationDate": activationDate,
        "SenderName": senderName,
        "ReceiverMobileNumber": receiverMobileNumber,
        "BrandName": brandName,
        "BranchName": branchName,
        "TriggerActionName": triggerActionName,
      };
}
