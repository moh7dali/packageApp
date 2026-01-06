import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int? id;
  final String? name;
  final String? imageUrl;
  final bool? hasSubcategory;
  final bool? hasProduct;
  final bool? hasFilters;

  const Category({this.id, this.name, this.imageUrl, this.hasSubcategory, this.hasProduct,this.hasFilters});

  @override
  List<Object?> get props => [id, name, imageUrl, hasSubcategory, hasProduct];
}

class CategoryList extends Equatable {
  final int? totalNumberofResult;
  final List<Category>? category;

  const CategoryList({
    this.category,
    this.totalNumberofResult,
  });

  @override
  List<Object?> get props => [category, totalNumberofResult];
}
