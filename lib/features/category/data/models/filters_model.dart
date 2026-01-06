import '../../domain/entities/filters.dart';

class FilterOptionModel extends FilterOption {
  const FilterOptionModel({required super.id, required super.value, required super.minValue, required super.maxValue, required super.label});

  factory FilterOptionModel.fromJson(Map<String, dynamic> json) =>
      FilterOptionModel(id: json["Id"], value: json["Value"], minValue: json["MinValue"], maxValue: json["MaxValue"], label: json["Label"]);

  Map<String, dynamic> toJson() => {"Id": id, "Value": value, "MinValue": minValue, "MaxValue": maxValue, "Label": label};
}

class FilterModel extends Filter {
  const FilterModel({required super.id, required super.name, required super.type, required super.isActive, required super.filterOptions});

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    id: json["Id"],
    name: json["Name"],
    type: json["Type"],
    isActive: json["IsActive"],
    filterOptions: json["FilterOptions"] == null
        ? []
        : List<FilterOption>.from((json["FilterOptions"] as List).map((x) => FilterOptionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Type": type,
    "IsActive": isActive,
    "FilterOptions": filterOptions == null ? [] : filterOptions!.map((x) => (x as FilterOptionModel).toJson()).toList(),
  };
}

class FiltersListModel extends FiltersList {
  const FiltersListModel({required super.totalNumberOfResult, required super.list});

  factory FiltersListModel.fromJson(Map<String, dynamic> json) => FiltersListModel(
    totalNumberOfResult: json["TotalNumberOfResult"],
    list: json["List"] == null ? [] : List<Filter>.from((json["List"] as List).map((x) => FilterModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TotalNumberOfResult": totalNumberOfResult,
    "List": list == null ? [] : list!.map((x) => (x as FilterModel).toJson()).toList(),
  };
}
