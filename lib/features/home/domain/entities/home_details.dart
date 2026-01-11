import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/home/domain/entities/slider_list.dart';
import 'package:my_custom_widget/features/home/domain/entities/tiers_list.dart';

import 'brand_data_list.dart';
import 'brand_list.dart';
import 'business_units_list.dart';
import 'customer_data.dart';
import 'malls_list.dart';

class HomeDetails extends Equatable {
  final SliderList? sliders;
  final BusinessUnitList? businessUnits;
  final BrandsList? brands;
  final MallsList? malls;
  final BrandDataList? brandsData;
  final TiersList? tiers;
  final CustomerData? customerData;

  const HomeDetails({this.sliders, this.businessUnits, this.brands, this.malls, this.brandsData, this.tiers, this.customerData});

  @override
  List<Object?> get props => [sliders, malls, brands, businessUnits, brandsData, tiers, customerData];
}
