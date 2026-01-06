import 'package:my_custom_widget/features/category/presentaion/getx/product_details_controller.dart';
import 'package:my_custom_widget/features/category/presentaion/widgets/product_details_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../widgets/product_details_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.product, required this.selectedCategory, this.isSlider = false});

  final Product product;
  final Category selectedCategory;
  final bool isSlider;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(product: product, selectedCategory: selectedCategory, isSlider: isSlider),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(title: Text(controller.productDetails?.name ?? "")),
          bottomNavigationBar: bottomNavBar(controller),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [controller.isLoading ? ProductDetailsLoading() : ProductDetailsWidget(controller: controller)],
              ),
            ),
          ),
        );
      },
    );
  }
}
