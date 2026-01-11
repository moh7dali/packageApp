import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../../my_custom_widget.dart';
import '../../domain/entities/category.dart';
import '../getx/sub_or_product_controller.dart';
import '../pages/sub_or_product_page.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.category, required this.parentCategoryList});

  final Category category;
  final List<Category> parentCategoryList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.delete<SubOrProductController>();
          SDKNav.to(SubOrProductPage(selectedCategory: category, parentCategoryList: parentCategoryList), preventDuplicates: false);
        },
        child: SizedBox(
          height: Get.height * .25,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: AppTheme.borderRadius,
                  child: Hero(
                    tag: "MainCategory${category.id}",
                    child: CachedNetworkImage(
                      imageUrl: (category.imageUrl ?? ""),
                      placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                      errorWidget: (c, e, s) => Image.asset(AssetsConsts.imageErrorLong, width: Get.width, fit: BoxFit.fill),
                      width: Get.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          category.name ?? "",
                          style: AppTheme.textStyle(
                            color: category.imageUrl == null ? AppTheme.primaryColor : AppTheme.whiteColor,
                            size: AppTheme.size18,
                            isBold: true,
                          ),
                          textAlign: category.imageUrl == null
                              ? appLanguage == "en"
                                    ? TextAlign.end
                                    : TextAlign.start
                              : appLanguage == "ar"
                              ? TextAlign.start
                              : TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
