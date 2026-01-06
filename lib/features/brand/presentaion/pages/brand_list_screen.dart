import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/features/brand/domain/entities/brand_details.dart';
import 'package:my_custom_widget/features/brand/presentaion/getx/brand_list_controller.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/app_card_widget.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';

class BrandListScreen extends StatelessWidget {
  const BrandListScreen({super.key, required this.businessUnitID});

  final int businessUnitID;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandListController>(
      init: BrandListController(businessUnitID),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            "brands",
            style: AppTheme.textStyle(color: Colors.black, isBold: true, size: 20),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PaginationListView<BrandDetails>(
                isList: false,
                loadFirstList: () async => await controller.getBusinessUnitBrands(page: 1),
                loadMoreList: (page) async => controller.getBusinessUnitBrands(page: page),
                itemBuilder: (context, value) => GestureDetector(
                  onTap: () {
                    // Get.toNamed(RouteConstant.brandDetailsPage, arguments: value.id!.toInt());
                  },
                  child: AppCard(
                    isWhite: true,
                    shape: RoundedRectangleBorder(borderRadius: AppTheme.borderRadius),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: AppTheme.borderRadius,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Hero(
                                      tag: "brandImage${value.id}",
                                      child: CachedNetworkImage(
                                        imageUrl: value.imageUrl ?? "",
                                        placeholder: (w, e) => Image.asset(
                                          AssetsConsts.loading,
                                          fit: BoxFit.cover,
                                        ),
                                        // imageBuilder: (context, imageProvider) => Container(
                                        //   decoration: BoxDecoration(
                                        //       image: DecorationImage(
                                        //     image: imageProvider,
                                        //     fit: BoxFit.cover,
                                        //   )),
                                        // ),
                                        fit: BoxFit.fill,
                                        errorWidget: (c, e, s) => Image.asset(AssetsConsts.imageError),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    value.name ?? "",
                                    maxLines: 1,
                                    style: AppTheme.textStyle(color: Colors.black, isBold: true, size: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                emptyWidget: Container(),
                loadingWidget: ClipRRect(
                  borderRadius: AppTheme.borderRadius,
                  child: Container(
                    child: Image.asset(
                      AssetsConsts.loading,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                emptyText: 'noBrands'.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
