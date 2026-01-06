import 'package:equatable/equatable.dart';

class FilterOption extends Equatable {
  final int? id;
  final String? value;
  final double? minValue;
  final double? maxValue;
  final String? label;

  const FilterOption({this.id, this.value, this.minValue, this.maxValue, this.label});

  @override
  List<Object?> get props => [id, value, minValue, maxValue, label];
}

class Filter extends Equatable {
  final int? id;
  final String? name;
  final int? type;
  final bool? isActive;
  final List<FilterOption>? filterOptions;

  const Filter({this.id, this.name, this.type, this.isActive, this.filterOptions});

  @override
  List<Object?> get props => [id, name, type, isActive, filterOptions];
}

class FiltersList extends Equatable {
  final int? totalNumberOfResult;
  final List<Filter>? list;

  const FiltersList({this.totalNumberOfResult, this.list});

  @override
  List<Object?> get props => [totalNumberOfResult, list];
}
