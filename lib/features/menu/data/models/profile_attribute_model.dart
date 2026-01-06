import '../../domain/entity/profile_attribute.dart';

class ProfileAttributeModel extends ProfileAttribute {
  const ProfileAttributeModel({
    required super.id,
    required super.name,
    required super.attributeDisplayValue,
    required super.dataType,
    required super.lookupCategoryId,
    required super.isRequired,
    required super.value,
  });

  factory ProfileAttributeModel.fromJson(Map<String, dynamic> json) {
    return ProfileAttributeModel(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      attributeDisplayValue: json['AttributeDisplayValue'] as String?,
      dataType: json['DataType'] as int?,
      lookupCategoryId: json['LookupCategoryId'] as int?,
      isRequired: json['IsRequired'] as bool?,
      value: json['Value']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'AttributeDisplayValue': attributeDisplayValue,
      'DataType': dataType,
      'LookupCategoryId': lookupCategoryId,
      'IsRequired': isRequired,
      'Value': value,
    };
  }
}
