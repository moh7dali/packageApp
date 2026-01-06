import '../../domain/entities/customer_info.dart';

class CustomerInfoModel extends CustomerInfo {
  const CustomerInfoModel({
    required super.id,
    required super.fullName,
    required super.mobileNumber,
    required super.gender,
  });

  factory CustomerInfoModel.fromMap(Map<String, dynamic> json) => CustomerInfoModel(
        id: json["Id"],
        fullName: json["FullName"],
        mobileNumber: json["MobileNumber"],
        gender: json["Gender"],
      );

  Map<String, dynamic> toMap() => {
        "Id": id,
        "FullName": fullName,
        "MobileNumber": mobileNumber,
        "Gender": gender,
      };
}
