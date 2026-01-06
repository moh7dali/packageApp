import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';
import 'package:my_custom_widget/features/category/domain/entities/category.dart';
import 'package:my_custom_widget/features/category/domain/entities/product.dart';
import 'package:my_custom_widget/features/category/domain/usecases/get_category_products.dart';
import 'package:my_custom_widget/features/category/domain/usecases/get_sub_categories.dart';
import 'package:my_custom_widget/shared/helper/shared_preferences_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../domain/entities/filters.dart';
import '../../domain/usecases/get_brand_categories.dart';
import '../../domain/usecases/get_category_filters.dart';

class SubOrProductController extends GetxController {
  final GetSubCategories getSubCategories;
  final GetCategoryProducts getCategoryProducts;
  final GetBrandCategories getBrandCategories;
  final GetCategoryFilters getCategoryFilters;

  SubOrProductController({required this.parentCategoryList, required this.selectedCategory, this.sliderCategoryId})
    : getSubCategories = sl(),
      getCategoryProducts = sl(),
      getBrandCategories = sl(),
      getCategoryFilters = sl();

  List<Category> parentCategoryList;
  Category selectedCategory;
  final int? sliderCategoryId;
  ScrollController scrollController = ScrollController();

  List<Category> categories = [];
  List<Product> product = [];
  bool isLoading = false;

  @override
  void onInit() {
    if (sliderCategoryId != null) {
      getCategoriesDetailsApi();
    }
    super.onInit();
  }

  Future<void> getCategoriesDetailsApi() async {
    await getBrandCategories.repository
        .getBrandCategories(body: {"brandId": "${AppConstants.brandId}", "pageNumber": "1", "CategoryId": "$sliderCategoryId"})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (list) {
              if ((list.category ?? []).isNotEmpty) {
                parentCategoryList = list.category!;
                selectedCategory = list.category!.first;
                update();
              }
            },
          ),
        );
  }

  Future<PaginationListModel> getSubCategoriesApi({int page = 1, required Category selectedCategory}) async {
    if (page == 1) {
      categories = [];
    }
    int totalNumberOfResult = 0;
    await getSubCategories.repository
        .getCategorySubCategories(queryParameters: {"categoryId": "${selectedCategory.id}", "pageNumber": "$page"})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (list) {
              List<Category> catForSize = list.category ?? [];
              categories.addAll(catForSize);
              totalNumberOfResult = list.totalNumberofResult ?? 0;
              update();
            },
          ),
        );
    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: categories);
  }

  Future<PaginationListModel> getProductApi({int page = 1, required Category selectedCategory}) async {
    product = [];
    int totalNumberOfResult = 0;
    BranchDetails? branch = await sl<SharedPreferencesStorage>().getSelectedBranch();
    final List<Map<String, dynamic>> apiFilters = _buildFiltersPayload();
    await getCategoryProducts.repository
        .getCategoryProducts(
          body: {
            "PageNumber": "$page",
            "CategoryId": "${selectedCategory.id}",
            if (branch != null) "BranchId": "${branch.id}",
            if (selectedFilters.isNotEmpty) 'Filters': apiFilters,
          },
        )
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (list) {
              List<Product> catForSize = list.product ?? [];
              product = catForSize;
              totalNumberOfResult = list.totalNumberofResult ?? 0;
              refreshTheList();
              refreshTheFilters();
              update();
            },
          ),
        );
    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: product);
  }

  Future<void> changeTab(Category newCat) async {
    isLoading = true;
    isFilterLoading = true;
    selectedCategory = newCat;
    selectedFilters.clear();
    refreshTheList();
    update();
  }

  void refreshTheList() {
    Future.delayed(Duration(milliseconds: 200), () {
      isLoading = false;
      update();
    });
  }

  List<Filter> selectedFilters = [];
  List<Filter> availableFilters = [];
  bool isFilterLoading = true;

  void setSelectedFilters(List<Filter> list) {
    isLoading = true;
    selectedFilters = List<Filter>.from(list);
    update();
    refreshTheList();
  }

  void clearAllSelectedFilters() {
    isLoading = true;
    selectedFilters.clear();
    update();
    refreshTheList();
  }

  void removeOneSelection(Filter f, FilterOption? opt) {
    isLoading = true;
    final idx = selectedFilters.indexWhere((x) => x.id == f.id);
    if (idx == -1) return;

    final current = selectedFilters[idx];

    if ((current.filterOptions ?? []).isEmpty || opt == null) {
      selectedFilters.removeAt(idx);
    } else {
      final newOpts = List<FilterOption>.from(current.filterOptions!);
      newOpts.removeWhere((o) => o.id == opt.id && o.value == opt.value);
      if (newOpts.isEmpty) {
        selectedFilters.removeAt(idx);
      } else {
        selectedFilters[idx] = Filter(id: current.id, name: current.name, type: current.type, isActive: current.isActive, filterOptions: newOpts);
      }
    }
    update();
    refreshTheList();
  }

  String optionLabel(Filter f, FilterOption o) {
    if (f.type == 5) {
      final minV = o.minValue ?? 0;
      final maxV = o.maxValue ?? 0;
      return 'Min: ${_fmtNum(minV)}  •  Max: ${_fmtNum(maxV)}';
    }
    final base = (o.label?.trim().isNotEmpty ?? false) ? o.label! : (o.value ?? '-');
    return base;
  }

  String _fmtNum(num n) {
    if (n is double) return n.toStringAsFixed(2);
    if (n is int) return n.toString();
    return n.toString();
  }

  void refreshTheFilters() {
    Future.delayed(Duration(milliseconds: 200), () {
      isFilterLoading = false;
      update();
    });
  }

  List<Map<String, dynamic>> _buildFiltersPayload() {
    final List<Map<String, dynamic>> out = [];

    for (final f in selectedFilters) {
      final fid = f.id;
      if (fid == null) continue;

      switch (f.type) {
        case 3:
          out.add({'FilterId': fid});
          break;

        case 4:
          final val = (f.filterOptions?.isNotEmpty ?? false) ? f.filterOptions!.first.value?.toString().trim() : null;
          if (val != null && val.isNotEmpty) {
            out.add({'FilterId': fid, 'Value': val});
          }
          break;

        case 1:
        case 2:
        case 5:
          for (final o in (f.filterOptions ?? const <FilterOption>[])) {
            final oid = o.id;
            if (oid == null) continue;
            out.add({'FilterId': fid, 'FilterOptionId': oid});
          }
          break;

        default:
          break;
      }
    }

    return out;
  }

  Future<PaginationListModel> getFiltersApi({int page = 1, required Category selectedCategory}) async {
    availableFilters = [];
    int totalNumberOfResult = 0;
    await getCategoryFilters.repository
        .getCategoryFilters(queryParameters: {"pageNumber": "$page", "id": "${selectedCategory.id}"})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (list) {
              availableFilters = list.list ?? [];
              totalNumberOfResult = list.totalNumberOfResult ?? 0;
              update();
            },
          ),
        );

    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: availableFilters);
  }

  bool isFilterSelected(Filter f) {
    final idx = selectedFilters.indexWhere((x) => x.id == f.id);
    if (idx == -1) return false;

    final current = selectedFilters[idx];
    if (current.type == 3) return true; // boolean filter on
    return (current.filterOptions?.isNotEmpty ?? false); // type 1/2/5 or type 4 with typed value
  }

  void applySingleFilterSelection(Filter base, List<FilterOption> chosen, {String? typedValue, bool includeType3 = false}) {
    final idx = selectedFilters.indexWhere((x) => x.id == base.id);

    Filter? toStore;

    switch (base.type) {
      case 3:
        if (includeType3) {
          toStore = Filter(id: base.id, name: base.name, type: base.type, isActive: base.isActive, filterOptions: const []);
        }
        break;

      case 4:
        final tv = (typedValue ?? '').trim();
        if (tv.isNotEmpty) {
          final typedOpt = FilterOption(id: -1, value: tv, label: tv, minValue: 0, maxValue: 0);
          toStore = Filter(id: base.id, name: base.name, type: base.type, isActive: base.isActive, filterOptions: [typedOpt]);
        }
        break;

      case 1:
      case 2:
      case 5:
        if (chosen.isNotEmpty) {
          toStore = Filter(id: base.id, name: base.name, type: base.type, isActive: base.isActive, filterOptions: chosen);
        }
        break;
      default:
        break;
    }

    if (toStore == null) {
      if (idx != -1) selectedFilters.removeAt(idx);
    } else {
      if (idx == -1) {
        selectedFilters.add(toStore);
      } else {
        selectedFilters[idx] = toStore;
      }
    }
    isLoading = true;
    update();
    refreshTheList();
  }
}
