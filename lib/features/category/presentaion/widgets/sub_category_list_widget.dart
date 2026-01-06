import 'package:my_custom_widget/features/category/presentaion/widgets/no_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../../notifications/presentation/widgets/notification_card_loading.dart';
import '../../domain/entities/category.dart';
import '../getx/sub_or_product_controller.dart';
import 'category_widget.dart';

class SubCategoryListWidget extends StatelessWidget {
  const SubCategoryListWidget({super.key, required this.controller, required this.selectedCategory, this.scrollController});

  final SubOrProductController controller;
  final Category selectedCategory;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return PaginationListView<Category>(
      scrollController: scrollController,
      loadFirstList: () async => await controller.getSubCategoriesApi(page: 1, selectedCategory: selectedCategory),
      loadMoreList: (page) async => controller.getSubCategoriesApi(page: page, selectedCategory: selectedCategory),
      itemBuilder: (context, value) => CategoryWidget(category: value, parentCategoryList: controller.categories),
      emptyWidget: NoProduct(),
      emptyText: "emptyList".tr,
      loadingWidget: const NotificationCardLoading(),
    );
  }
}
