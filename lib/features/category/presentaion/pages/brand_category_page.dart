import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/category/domain/entities/category.dart';
import 'package:my_custom_widget/features/category/presentaion/getx/brand_category_controller.dart';
import 'package:my_custom_widget/shared/widgets/app_background.dart';

import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../../notifications/presentation/widgets/notification_card_loading.dart';
import '../../../ordering/presentation/widget/cart_icon_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/no_product.dart';

class BrandCategoryPage extends StatelessWidget {
  const BrandCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandCategoryController>(
      init: BrandCategoryController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text("menu".tr), actions: [CartIconWidget()]),
          extendBodyBehindAppBar: true,
          body: AppBackground(
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: PaginationListView<Category>(
                        loadFirstList: () async => await controller.getBrandCategoriesApi(page: 1),
                        loadMoreList: (page) async => controller.getBrandCategoriesApi(page: page),
                        itemBuilder: (context, value) => CategoryWidget(category: value, parentCategoryList: controller.categories),
                        emptyWidget: NoProduct(),
                        emptyText: "emptyList".tr,
                        loadingWidget: const NotificationCardLoading(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
