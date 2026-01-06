import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/category/presentaion/getx/filters_controller.dart';

import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../../notifications/presentation/widgets/notification_card_loading.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/filters.dart';
import '../widgets/filter_widget.dart';
import '../widgets/no_product.dart';

class FiltersPage extends StatelessWidget {
  const FiltersPage({super.key, required this.selectedCategory});

  final Category selectedCategory;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FiltersController>(
      init: FiltersController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppTheme.secondaryColor,
          bottomNavigationBar: controller.hasSelections ? BottomNavBarWidget(controller: controller) : null,
          appBar: AppBar(title: Text('filter'.tr), backgroundColor: AppTheme.secondaryColor),
          body: PaginationListView<Filter>(
            loadFirstList: () async => await controller.getFiltersApi(page: 1, selectedCategory: selectedCategory),
            loadMoreList: (page) async => await controller.getFiltersApi(page: page, selectedCategory: selectedCategory),
            itemBuilder: (context, value) => FilterCard(filter: value),
            emptyWidget: NoProduct(),
            emptyText: "",
            loadingWidget: const NotificationCardLoading(),
          ),
        );
      },
    );
  }
}
