import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/category/presentaion/widgets/no_product.dart';
import 'package:my_custom_widget/features/category/presentaion/widgets/product_widget.dart';

import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../../notifications/presentation/widgets/notification_card_loading.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../getx/sub_or_product_controller.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key, required this.controller, required this.selectedCategory, this.scrollController});

  final SubOrProductController controller;
  final Category selectedCategory;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return PaginationListView<Product>(
      isList: false,
      scrollController: scrollController,
      loadFirstList: () async => await controller.getProductApi(page: 1, selectedCategory: selectedCategory),
      loadMoreList: (page) async => await controller.getProductApi(page: page, selectedCategory: selectedCategory),
      itemBuilder: (context, value) => ProductWidget(product: value, selectedCategory: selectedCategory),
      emptyWidget: NoProduct(),
      emptyText: "emptyList".tr,
      loadingWidget: const NotificationCardLoading(),
    );
  }
}
