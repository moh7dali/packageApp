import 'business_unit.dart';

class BusinessUnitList extends BusinessUnit {
  final List<BusinessUnit>? businessUnits;
  final int? totalNumberOfResult;

  const BusinessUnitList({this.businessUnits, this.totalNumberOfResult});

  @override
  List<Object?> get props => [businessUnits, totalNumberOfResult];
}
