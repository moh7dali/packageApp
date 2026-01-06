import 'brand_data.dart';

class BrandDataList extends BrandsData {
  final List<BrandsData>? brandsData;
  final int? totalNumberOfResult;

  const BrandDataList({this.brandsData, this.totalNumberOfResult});

  @override
  List<Object?> get props => [brandsData, totalNumberOfResult];
}
