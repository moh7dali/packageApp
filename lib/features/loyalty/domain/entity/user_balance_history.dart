import 'package:equatable/equatable.dart';

class UserBalanceHistory extends Equatable {
  final int? numberOfPoints;
  final String? creationDate;
  final dynamic expiryDate;
  final int? triggerType;
  final String? source;
  final String? brandName;
  final String? branchName;
  final String? triggerActionName;
  final int? currentStatus;
  final dynamic activationDate;
  final dynamic senderName;
  final dynamic receiverMobileNumber;

  const UserBalanceHistory({
    required this.numberOfPoints,
    required this.creationDate,
    required this.expiryDate,
    required this.triggerType,
    required this.source,
    required this.brandName,
    required this.branchName,
    required this.triggerActionName,
    required this.currentStatus,
    required this.activationDate,
    required this.senderName,
    required this.receiverMobileNumber,
  });

  @override
  List<Object?> get props => [
        numberOfPoints,
        creationDate,
        expiryDate,
        triggerType,
        source,
        brandName,
        branchName,
        triggerActionName,
        currentStatus,
        activationDate,
        senderName,
        receiverMobileNumber,
      ];
}
