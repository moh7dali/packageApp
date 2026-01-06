import 'package:my_custom_widget/features/category/presentaion/getx/product_widget_controller.dart';
import 'package:my_custom_widget/features/category/presentaion/pages/product_details_page.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_preferences_storage.dart';
import '../../../../shared/widgets/add_to_cart_dialog.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product, required this.selectedCategory});

  final Product product;
  final Category selectedCategory;

  bool get isActive => product.isActiveForTheSelectedBranch ?? true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductWidgetController>(
      init: ProductWidgetController(selectedCategory: selectedCategory, product: product),
      tag: 'Product${product.id}',
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Opacity(
            opacity: isActive ? 1.0 : 0.35,
            child: GestureDetector(
              onTap: () async {
                if (isActive) {
                  Get.bottomSheet(
                    FractionallySizedBox(
                      heightFactor: .956,
                      child: ProductDetailsPage(product: product, selectedCategory: selectedCategory),
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    barrierColor: AppTheme.bgThemeColor,
                  );
                } else {
                  SharedHelper().notAvailableProductInBranch(branch: await sl<SharedPreferencesStorage>().getSelectedBranch());
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.primaryColor.withOpacity(.10)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 24, offset: const Offset(0, 14))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Stack(
                          children: [
                            Positioned.fill(child: _buildProductImage()),

                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.black.withOpacity(.35)],
                                  ),
                                ),
                              ),
                            ),

                            if ((product.offerPrice ?? 0) > 0)
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(color: Colors.black.withOpacity(.06)),
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 14, offset: const Offset(0, 8))],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [Icon(Icons.local_offer_rounded, size: 16, color: AppTheme.primaryColor)],
                                  ),
                                ),
                              ),
                            if (!isActive)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withOpacity(.35),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
                                      child: Text(
                                        "notAvailable".tr,
                                        style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(padding: const EdgeInsets.fromLTRB(12, 10, 12, 12), child: _buildProductDetails(controller)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(ProductWidgetController controller) {
    final bool hasStock = product.hasStock ?? false;
    final int apiQty = product.quantity ?? 0;
    final int selected = controller.quantity;
    final bool isOutOfStock = hasStock && apiQty == 0;
    if (isOutOfStock) {
      return Padding(padding: const EdgeInsets.only(top: 8), child: _outOfStockPill());
    }
    if (selected == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GestureDetector(
          onTap: () async {
            SharedHelper().needLogin(() async {
              if (hasStock && apiQty <= 0) {
                SharedHelper().actionDialog("title", "$apiQty ${'MaxQuantity'.tr}", noCancel: true, confirm: Get.back);
                return;
              }

              final exceed = await controller.willExceedMaxAfterAdd(productDetails: controller.productDetails, addQty: 1);

              if (exceed) {
                controller.showExceededMaximumPurchaseAmountPopUp();
                return;
              }

              controller.increaseQuantity();
              SharedHelper().scaleDialog(AddToCartDialog());
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppTheme.primaryColor.withOpacity(.1),
              border: Border.all(color: AppTheme.primaryColor),
            ),
            child: Center(
              child: Text(
                'addToCart'.tr,
                style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.bgThemeColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _qtyBtn(controller.quantity <= 1 ? Icons.delete_outline : Icons.remove, controller.decreaseQuantity),
            Text(
              '${controller.quantity}',
              style: AppTheme.textStyle(size: AppTheme.size16, isBold: true, color: AppTheme.primaryColor),
            ),
            _qtyBtn(Icons.add, () async {
              if (hasStock && selected >= apiQty) {
                SharedHelper().actionDialog("title", "$apiQty ${'MaxQuantity'.tr}", noCancel: true, confirm: Get.back);
                return;
              }

              final exceed = await controller.willExceedMaxAfterAdd(productDetails: controller.productDetails, addQty: 1);

              if (exceed) {
                controller.showExceededMaximumPurchaseAmountPopUp();
                return;
              }

              controller.increaseQuantity();
            }),
          ],
        ),
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor.withOpacity(.12)),
        child: Icon(icon, color: AppTheme.primaryColor, size: 20),
      ),
    );
  }

  Widget _outOfStockPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.withOpacity(.35)),
      ),
      child: Text(
        'outOfStock'.tr,
        style: AppTheme.textStyle(size: AppTheme.size12, color: Colors.red, isBold: true),
      ),
    );
  }

  Widget _buildProductDetails(ProductWidgetController controller) {
    final bool hasPrice = (product.price ?? 0) > 0 || (product.offerPrice ?? 0) > 0;
    final bool hasModifiers = product.hasItemModifiers ?? false;

    final String name = product.name?.toString().capitalize ?? '';
    final String description = product.description ?? '';

    return LayoutBuilder(
      builder: (context, constraints) {
        final TextStyle nameStyle = AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14);
        final TextPainter namePainter = TextPainter(
          text: TextSpan(text: name, style: nameStyle),
          maxLines: 2,
          textDirection: Directionality.of(context),
        )..layout(maxWidth: constraints.maxWidth);

        final int nameLineCount = namePainter.computeLineMetrics().length;

        int descriptionMaxLines = 0;

        if (nameLineCount >= 2) {
          descriptionMaxLines = 0;
        } else if (nameLineCount == 1 && description.isNotEmpty) {
          if (!hasPrice) {
            descriptionMaxLines = 2;
          } else {
            descriptionMaxLines = 1;
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: nameStyle, maxLines: 2, overflow: TextOverflow.ellipsis),

            if (descriptionMaxLines > 0) ...[
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  description,
                  style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(0.75), size: AppTheme.size12),
                  maxLines: descriptionMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            const Spacer(),

            if (hasPrice) _buildProductPriceRow(),

            const Spacer(),

            if (!isActive) const SizedBox.shrink() else if (hasModifiers) _showOptionsPill() else if (!hasModifiers) _buildActionButton(controller),
          ],
        );
      },
    );
  }

  Widget _showOptionsPill() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(.25)),
      ),
      child: Center(
        child: Text(
          'showOptions'.tr,
          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
        ),
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      '${product.name?.toString().capitalize}',
      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        '${product.description}',
        style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(0.75), size: AppTheme.size12),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildProductPriceRow() {
    final hasOffer = (product.offerPrice ?? 0) > 0;

    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurrencyAmountText(
            amountText: SharedHelper.getNumberFormat(product.price ?? 0),
            amountStyle: AppTheme.textStyle(
              color: AppTheme.textColor,
              size: AppTheme.size16,
              isBold: true,
            ).copyWith(decoration: hasOffer ? TextDecoration.lineThrough : TextDecoration.none, decorationColor: AppTheme.primaryColor),
          ),
          if (hasOffer) SizedBox(width: 10),
          if (hasOffer)
            CurrencyAmountText(
              amountText: SharedHelper.getNumberFormat(product.offerPrice ?? 0),
              amountStyle: AppTheme.textStyle(color: Colors.green, size: AppTheme.size16, isBold: true),
            ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: product.imageUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
          errorWidget: (context, url, error) => Image.asset(AssetsConsts.imageError, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
