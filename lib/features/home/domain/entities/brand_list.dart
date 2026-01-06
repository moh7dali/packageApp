import 'brands.dart';

class BrandsList extends Brands {
  final List<Brands>? brands;
  final int? totalNumberOfResult;

  const BrandsList({this.brands, this.totalNumberOfResult});

  @override
  List<Object?> get props => [brands, totalNumberOfResult];
}
