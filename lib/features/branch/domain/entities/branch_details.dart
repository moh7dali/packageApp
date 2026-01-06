import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/branch/domain/entities/branch_image.dart';

class BranchDetails extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? mobile;
  final num? latitude;
  final num? longitude;
  final String? openTime;
  final String? closeTime;
  final String? address;
  final List<BranchImages>? branchImages;

  const BranchDetails({
    this.id,
    this.name,
    this.description,
    this.mobile,
    this.latitude,
    this.longitude,
    this.openTime,
    this.closeTime,
    this.address,
    this.branchImages,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        mobile,
        latitude,
        longitude,
        openTime,
        closeTime,
        address,
        branchImages,
      ];
}
