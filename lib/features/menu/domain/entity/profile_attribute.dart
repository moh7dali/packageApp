import 'package:equatable/equatable.dart';

class ProfileAttribute extends Equatable {
  final int? id;
  final String? name;
  final String? attributeDisplayValue;
  final int? dataType;
  final int? lookupCategoryId;
  final bool? isRequired;
  final String? value;

  const ProfileAttribute({
    required this.id,
    required this.name,
    required this.attributeDisplayValue,
    required this.dataType,
    required this.lookupCategoryId,
    required this.isRequired,
    required this.value,
  });

  @override
  List<Object?> get props => [id, name, dataType, lookupCategoryId, isRequired, value,attributeDisplayValue];
}
