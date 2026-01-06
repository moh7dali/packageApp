import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/brand/domain/entities/brand_details.dart';

class BrandDetailsList extends Equatable {
  final int? totalNumberofResult;
  final List<BrandDetails>? brands;

  const BrandDetailsList({
    this.brands,
    this.totalNumberofResult,
  });

  @override
  List<Object?> get props => [brands, totalNumberofResult];
}
