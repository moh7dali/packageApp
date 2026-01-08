import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/category/presentaion/getx/product_details_controller.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../shared/widgets/image_preview_widget.dart';
import '../../../../shared/widgets/profile_text_field.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../../domain/entities/product_details.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({super.key, required this.controller});

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.size16),
      child: Column(
        spacing: AppTheme.size20,
        children: [
          _buildImageSlider(controller.productDetails?.productItemImages, context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  controller.productDetails?.name ?? "",
                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16, isBold: true),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          priceSectionWidget(controller),
          youTubeWidget(controller.productDetails?.videoUrl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  controller.productDetails?.description ?? "",
                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          QuantitySection(controller: controller),
          ModifiersSectionWidget(controller: controller),
          ProfileTextField(
            label: 'note',
            type: TextInputType.multiline,
            showLabelAsHeader: false,
            controller: controller.noteController,
            padding: EdgeInsets.symmetric(vertical: Get.height * .075, horizontal: 16),
            isBigRad: false,
            maxLength: 300,
            maxLine: 5,
            shakeKey: controller.noteShakeKey,
          ),
        ],
      ),
    );
  }
}

class ModifiersSectionWidget extends StatelessWidget {
  const ModifiersSectionWidget({super.key, required this.controller});

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.scrollController,
      itemCount: controller.productModifierWithoutSize.length,
      itemBuilder: (context, index) {
        final modifier = controller.productModifierWithoutSize[index];
        final isExpanded = controller.expansionStates[index];
        final isSelected = controller.isModifierSelected(modifier);

        return Container(
          key: controller.optionKeys[index],
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            borderRadius: AppTheme.bigBorderRadius,
            color: AppTheme.bgThemeColor,
            border: Border.all(color: isSelected ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(.15), width: isSelected ? 1.5 : 1),
          ),
          child: Column(
            children: [
              // ================= HEADER =================
              InkWell(
                borderRadius: AppTheme.bigBorderRadius,
                onTap: () {
                  if (!isExpanded) {
                    controller.updateExpansionState(index);
                    Future.delayed(const Duration(milliseconds: 300), () {
                      final keyContext = controller.optionKeys[index].currentContext;
                      if (keyContext != null) {
                        Scrollable.ensureVisible(keyContext, duration: const Duration(milliseconds: 500), alignment: 0.05);
                      }
                    });
                  } else {
                    controller.closeExpansion(index);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      // ✔ Selected indicator
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(.08),
                        ),
                        child: isSelected ? const Icon(Icons.check, size: 18, color: Colors.white) : const SizedBox.shrink(),
                      ),

                      const SizedBox(width: 12),

                      // Title
                      Expanded(
                        child: Text(
                          modifier.displayName ?? "",
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                        ),
                      ),

                      // Arrow
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 250),
                        child: Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.primaryColor, size: 28),
                      ),
                    ],
                  ),
                ),
              ),

              // ================= EXPANSION =================
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                child: isExpanded
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(22), bottomRight: Radius.circular(22)),
                        ),
                        child: modifier.type == 1 ? multiOptions(modifier, controller) : requiredOptions(modifier, controller, index),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class QuantitySection extends StatelessWidget {
  const QuantitySection({super.key, required this.controller});

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppTheme.bgThemeColor, borderRadius: AppTheme.bigBorderRadius),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _qtyBtn(Icons.remove, controller.quantitySub),
          Text(
            "${controller.quantity}",
            style: AppTheme.textStyle(size: AppTheme.size18, isBold: true, color: AppTheme.primaryColor),
          ),
          _qtyBtn(Icons.add, controller.quantityAdd),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor.withOpacity(.1)),
        child: Icon(icon, color: AppTheme.primaryColor),
      ),
    );
  }
}

Widget _buildImageSlider(List<ProductImage>? imageUrls, BuildContext context) {
  final imageHeight = Get.height * 0.35;

  if ((imageUrls ?? []).isEmpty) {
    return SizedBox(
      height: imageHeight,
      child: Image.asset(AssetsConsts.imageError, fit: BoxFit.contain, width: Get.width),
    );
  }

  if (imageUrls?.length == 1) {
    return _buildCachedImage(imageUrls?.firstOrNull?.imageUrl ?? "", context, imageHeight);
  }

  return CarouselSlider(
    items: imageUrls?.map((url) => _buildCachedImage(url.imageUrl ?? "", context, imageHeight)).toList(),
    options: CarouselOptions(
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 4),
      autoPlayAnimationDuration: const Duration(milliseconds: 300),
      height: imageHeight,
      viewportFraction: 1,
      enlargeCenterPage: false,
    ),
  );
}

Widget _buildCachedImage(String url, BuildContext context, double height) {
  return GestureDetector(
    onTap: () {
      context.pushTransparentRoute(ImagePreview(image: url));
    },
    child: ClipRRect(
      borderRadius: AppTheme.borderRadius,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.contain,
        height: height,
        placeholder: (context, _) => Image.asset(AssetsConsts.loading, fit: BoxFit.contain, height: height),
        errorWidget: (context, _, __) => Image.asset(AssetsConsts.imageError, fit: BoxFit.contain, height: height),
      ),
    ),
  );
}

Widget requiredOptions(ProductModifier item, ProductDetailsController controller, int index) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: item.modifierOptions!.length,
    itemBuilder: (context, itemIndex) => ListTile(
      onTap: () {
        controller.selectRadio(item, item.modifierOptions![itemIndex]);
        controller.closeExpansion(index);
      },
      leading: IgnorePointer(
        ignoring: true,
        child: Radio<ModifierOption>(
          activeColor: AppTheme.primaryColor,
          value: item.modifierOptions![itemIndex],
          groupValue: controller.selectedOptions
              .firstWhereOrNull((element) => element.selectedOption == item.modifierOptions![itemIndex])
              ?.selectedOption,
          onChanged: (val) {},
        ),
      ),
      title: Text(
        item.modifierOptions![itemIndex].name!,
        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
      ),
      trailing: CurrencyAmountText(
        amountText: SharedHelper.getNumberFormat(item.modifierOptions![itemIndex].price ?? 0),
        amountStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
      ),
    ),
  );
}

Widget multiOptions(ProductModifier item, ProductDetailsController controller) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: item.modifierOptions?.length ?? 0,
    itemBuilder: (context, itemIndex) {
      ModifierOption option = item.modifierOptions![itemIndex];
      return ListTile(
        onTap: () {
          controller.toggleCheckbox(item, option);
        },
        leading: IgnorePointer(
          ignoring: true,
          child: Checkbox(activeColor: AppTheme.primaryColor, value: controller.isOptionSelected(item, option), onChanged: (val) {}),
        ),
        title: Text(
          option.name!,
          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
        ),
        trailing: CurrencyAmountText(
          amountText: SharedHelper.getNumberFormat(option.price ?? 0),
          amountStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
        ),
      );
    },
  );
}

Widget priceSectionWidget(ProductDetailsController controller) {
  final sizeModifier = controller.sizeModifier.firstOrNull;
  final sizeOptions = sizeModifier?.modifierOptions ?? [];
  final hasSizeOptions = sizeOptions.isNotEmpty;
  final hasOffer = (controller.productDetails?.offerPrice ?? 0) > 0;

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    decoration: BoxDecoration(
      color: AppTheme.bgThemeColor,
      borderRadius: AppTheme.bigBorderRadius,
      border: Border.all(color: AppTheme.primaryColor.withOpacity(.12)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!hasSizeOptions) ...[
          if (hasOffer)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CurrencyAmountText(
                  amountText: SharedHelper.getNumberFormat(controller.productDetails?.price ?? 0),
                  amountStyle: AppTheme.textStyle(
                    color: AppTheme.textColor.withOpacity(.6),
                    size: AppTheme.size14,
                  ).copyWith(decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          const SizedBox(height: 6),
          CurrencyAmountText(
            amountText: SharedHelper.getNumberFormat(
              hasOffer ? (controller.productDetails?.offerPrice ?? 0) : (controller.productDetails?.price ?? 0),
            ),
            amountStyle: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size20, isBold: true),
          ),
        ],

        if (hasSizeOptions) ...[
          Text(
            sizeModifier?.displayName ?? 'selectSize'.tr,
            style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.8), size: AppTheme.size14, isBold: true),
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: controller.selectedPrice == 0
                ? Text(
                    'selectSize'.tr,
                    key: const ValueKey('selectSize'),
                    style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.6), size: AppTheme.size14),
                  )
                : CurrencyAmountText(
                    key: const ValueKey('price'),
                    amountText: SharedHelper.getNumberFormat(controller.selectedPrice),
                    amountStyle: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size20, isBold: true),
                  ),
          ),

          const SizedBox(height: 14),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: sizeOptions.map((modifier) {
                final isSelected = controller.selectedPrice == (modifier.price ?? 0);
                return GestureDetector(
                  onTap: () {
                    controller.setSelectedSize(sizeModifier!, modifier);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: AppTheme.bigBorderRadius,
                      color: isSelected ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(.08),
                      border: Border.all(color: isSelected ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(.25)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          modifier.name ?? "",
                          style: AppTheme.textStyle(
                            color: isSelected ? AppTheme.accentColor : AppTheme.textColor,
                            size: AppTheme.size14,
                            isBold: true,
                          ),
                        ),
                        const SizedBox(height: 4),
                        CurrencyAmountText(
                          amountText: SharedHelper.getNumberFormat(modifier.price ?? 0),
                          amountStyle: AppTheme.textStyle(
                            color: isSelected ? AppTheme.accentColor.withOpacity(.9) : AppTheme.textColor.withOpacity(.7),
                            size: AppTheme.size12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    ),
  );
}

Widget bottomNavBar(ProductDetailsController controller) {
  final hasStock = controller.productDetails?.hasStock ?? false;
  final qty = controller.productDetails?.quantity ?? 0;

  final isOutOfStock = hasStock && qty <= 0;
  final canOrder = !isOutOfStock;

  final showSelectSize = controller.sizeModifier.isNotEmpty && controller.selectedPrice == 0;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AbsorbPointer(
          absorbing: !canOrder || controller.isLoading,
          child: GestureDetector(
            onTap: () {
              if (canOrder) {
                SharedHelper().needLogin(() {
                  if (!controller.isLoading) {
                    controller.validateProduct();
                  }
                });
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(borderRadius: AppTheme.bigBorderRadius, color: canOrder ? AppTheme.primaryColor : AppTheme.redColor),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: isOutOfStock ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                children: [
                  if (isOutOfStock)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.warning_outlined, color: Colors.yellow, size: AppTheme.size30),
                    ),
                  Text(
                    isOutOfStock ? "outOfStock".tr : "addToCart".tr,
                    style: AppTheme.textStyle(color: AppTheme.accentColor, size: AppTheme.size16, isBold: true),
                  ),
                  if (!controller.isLoading && canOrder)
                    (canOrder && showSelectSize)
                        ? Text(
                            "selectSize".tr,
                            style: AppTheme.textStyle(color: AppTheme.accentColor, size: AppTheme.size16, isBold: true),
                          )
                        : CurrencyAmountText(
                            amountText: SharedHelper.getNumberFormat(controller.totalPrice),
                            amountStyle: AppTheme.textStyle(color: AppTheme.accentColor, size: AppTheme.size16, isBold: true),
                          ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget youTubeWidget(String? url) {
  if (url == null || url == "") {
    return SizedBox();
  }
  return GestureDetector(
    onTap: () async {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: AppTheme.borderRadius, color: AppTheme.primaryColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(width: Get.width * .05),
              Container(
                decoration: BoxDecoration(borderRadius: AppTheme.borderRadius, color: Colors.white),
                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Icon(Icons.play_arrow_rounded, size: 40, color: AppTheme.primaryColor),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'watchOnYoutube'.tr,
                    style: AppTheme.textStyle(color: Colors.white, size: AppTheme.size16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
