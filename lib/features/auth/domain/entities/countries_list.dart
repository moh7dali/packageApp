import 'package:equatable/equatable.dart';

import 'country.dart';

class CountriesList extends Equatable {
  final int? totalNumberOfResult;
  final List<Country>? countries;

  const CountriesList({required this.totalNumberOfResult, required this.countries});

  @override
  List<Object?> get props => [totalNumberOfResult, countries];
}
