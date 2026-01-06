import '../../domain/entities/application_version.dart';

class ApplicationVersionModel extends ApplicationVersion {
  const ApplicationVersionModel({
    required super.systemVersion,
    required super.needsUpdating,
    required super.isActive,
    required super.inActiveReason,
  });

  factory ApplicationVersionModel.fromJson(Map<String, dynamic> json) => ApplicationVersionModel(
        systemVersion: json['SystemVersion'],
        needsUpdating: json['NeedsUpdating'],
        isActive: json['IsActive'],
        inActiveReason: json['InActiveReason'],
      );

  ApplicationVersion get applicationVersion => ApplicationVersion(
        systemVersion: systemVersion,
        needsUpdating: needsUpdating,
        isActive: isActive,
        inActiveReason: inActiveReason,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SystemVersion'] = systemVersion;
    map['NeedsUpdating'] = needsUpdating;
    map['IsActive'] = isActive;
    map['InActiveReason'] = inActiveReason;
    return map;
  }
}
