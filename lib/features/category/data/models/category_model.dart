import 'package:my_custom_widget/features/category/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.hasProduct,
    required super.hasSubcategory,
    required super.hasFilters,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["Id"],
    name: json["Name"],
    imageUrl: json["ImageUrl"],
    hasProduct: json["HasProduct"],
    hasSubcategory: json["HasSubcategory"],
    hasFilters: json["HasFilters"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "ImageUrl": imageUrl,
    "HasSubcategory": hasSubcategory,
    "HasProduct": hasProduct,
    "HasFilters": hasFilters,
  };
}

class CategoryListModel extends CategoryList {
  const CategoryListModel({required super.totalNumberofResult, required super.category});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
    totalNumberofResult: json["TotalNumberOfResult"],
    category: json["List"] == null ? [] : List<Category>.from(json["List"]!.map((x) => CategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {"TotalNumberOfResult": totalNumberofResult, "List": Category};
}
