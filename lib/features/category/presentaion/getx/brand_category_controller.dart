import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/features/category/domain/usecases/get_brand_categories.dart';
import 'package:get/get.dart';

import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../domain/entities/category.dart';

class BrandCategoryController extends GetxController {
  final GetBrandCategories getBrandCategories;

  BrandCategoryController() : getBrandCategories = sl();

  List<Category> categories = [];

  Future<PaginationListModel> getBrandCategoriesApi({int page = 1}) async {
    categories = [];
    int totalNumberOfResult = 0;
    await getBrandCategories.repository.getBrandCategories(body: {
      "brandId": "${AppConstants.brandId}",
      "pageNumber": "$page",
      "GetRootCategoryOnly": true
    }).then((value) => value.fold((failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        }, (list) {
          List<Category> catForSize = list.category ?? [];
          categories = catForSize;
          totalNumberOfResult = list.totalNumberofResult ?? 0;
          update();
        }));
    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: categories);
  }
}
