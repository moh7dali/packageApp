import 'package:my_custom_widget/features/category/data/models/category_model.dart';
import 'package:my_custom_widget/features/category/data/models/filters_model.dart';
import 'package:my_custom_widget/features/category/data/models/product_details_model.dart';
import 'package:my_custom_widget/features/category/data/models/product_model.dart';
import 'package:my_custom_widget/features/category/domain/entities/filters.dart';
import 'package:my_custom_widget/features/category/domain/entities/product.dart';
import 'package:my_custom_widget/features/category/domain/entities/product_details.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entities/category.dart';

abstract class CategoryApiDataSource {
  Future<CategoryList> getBrandCategories({required Map<String, dynamic> body});

  Future<CategoryList> getCategorySubCategories({Map<String, dynamic>? queryParameters});

  Future<ProductList> getCategoryProducts({required Map<String, dynamic> body});

  Future<ProductDetails> getProductDetails({Map<String, dynamic>? queryParameters});

  Future<FiltersList> getCategoryFilters({Map<String, dynamic>? queryParameters});
}

class CategoryApiDataSourceImpl implements CategoryApiDataSource {
  @override
  Future<CategoryList> getBrandCategories({required Map<String, dynamic> body}) async {
    CategoryList brandCategoryList = await ApiRequest<CategoryList>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getBrandCategories,
      body: body,
      fromJson: CategoryListModel.fromJson,
    );
    return brandCategoryList;
  }

  @override
  Future<CategoryList> getCategorySubCategories({Map<String, dynamic>? queryParameters}) async {
    CategoryList subCategoryList = await ApiRequest<CategoryList>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getCategorySubCategories,
      body: {},
      queryParameters: queryParameters,
      fromJson: CategoryListModel.fromJson,
    );
    return subCategoryList;
  }

  @override
  Future<ProductList> getCategoryProducts({required Map<String, dynamic> body}) async {
    ProductList productList = await ApiRequest<ProductList>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getCategoryProducts,
      body: body,
      authorized: await SharedHelper().isUserLoggedIn(),
      fromJson: ProductListModel.fromJson,
    );
    return productList;
  }

  @override
  Future<ProductDetails> getProductDetails({Map<String, dynamic>? queryParameters}) async {
    ProductDetails productDetails = await ApiRequest<ProductDetails>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getProductDetails,
      body: {},
      authorized: await SharedHelper().isUserLoggedIn(),
      queryParameters: queryParameters,
      fromJson: ProductDetailsModel.fromJson,
    );
    return productDetails;
  }

  @override
  Future<FiltersList> getCategoryFilters({Map<String, dynamic>? queryParameters}) async {
    FiltersList filtersList = await ApiRequest<FiltersList>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getCategoryFilters,
      body: {},
      queryParameters: queryParameters,
      fromJson: FiltersListModel.fromJson,
    );
    return filtersList;
  }
}
