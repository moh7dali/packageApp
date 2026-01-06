import 'package:equatable/equatable.dart';

import 'brands.dart';

class BrandsData extends Equatable {
  final int? businessUnitId;
  final List<Brands>? brands;

  const BrandsData({
    this.businessUnitId,
    this.brands,
  });

  @override
  List<Object?> get props => [businessUnitId, brands];
}
