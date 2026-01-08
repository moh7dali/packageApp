import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/address/domain/entity/address.dart';
import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:my_custom_widget/shared/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../my_custom_widget.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../../domain/entity/order_details.dart';
import '../getx/order_detail_controller.dart';

Widget _orderItemCard(int index, OrderDetailsController controller) {
  final item = controller.orderDetails?.orderItems?[index];
  if (item == null) return const SizedBox();
  return Container(
    decoration: BoxDecoration(
      color: AppTheme.bgColor,
      borderRadius: AppTheme.bigBorderRadius,
      border: Border.all(color: AppTheme.primaryColor.withOpacity(.15)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _buildProductImage(item.imageUrl),
          const SizedBox(width: 8),
          Expanded(child: _buildItemDetails(item)),
          const SizedBox(width: 12),
        ],
      ),
    ),
  );
}

Widget _buildProductImage(String? url) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: AppTheme.borderRadius,
      child: CachedNetworkImage(
        imageUrl: url ?? '',
        placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
        errorWidget: (c, e, s) => Image.asset(AssetsConsts.imageError, height: Get.width * 0.2),
        fit: BoxFit.cover,
        width: Get.width * 0.3,
      ),
    ),
  );
}

Widget _buildItemDetails(OrderItem item) {
  final hasOffer = (item.offerPrice ?? 0) > 0;
  final hasPrice = (item.unitPrice ?? 0) > 0;
  final priceWidget = hasOffer
      ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              SharedHelper.getNumberFormat(item.unitPrice ?? 0),
              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12).copyWith(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(width: 4),
            Text(
              SharedHelper.getNumberFormat(item.offerPrice ?? 0),
              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
            ),
          ],
        )
      : Text(
          SharedHelper.getNumberFormat(item.unitPrice ?? 0),
          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
        );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTitle(item.itemName),
      _divider(),
      if (hasPrice) _infoRow('oneItemPrice'.tr, priceWidget),
      _infoRow(
        'quantity'.tr,
        Text(
          '${item.quantity}',
          style: AppTheme.textStyle(size: AppTheme.size10, color: AppTheme.textColor),
        ),
      ),
      // if (item.size != null && item.size != '') _infoRow('size'.tr, Text(item.size ?? '', style: AppTheme.textStyle(size: AppTheme.size10))),
      if ((item.modifierOptions ?? []).isNotEmpty) _buildOptionsList(item),
      _divider(),
      _infoRow(
        'totalPrice'.tr,
        Text(
          SharedHelper.getNumberFormat(item.subTotalPrice ?? 0),
          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size10),
        ),
      ),
    ],
  );
}

Widget _buildTitle(String? name) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      name ?? '',
      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
    ),
  );
}

Widget _divider() {
  return Container(height: 2, color: AppTheme.primaryColor.withOpacity(0.2));
}

Widget _infoRow(String title, Widget value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size10),
        ),
        value,
      ],
    ),
  );
}

Widget _buildOptionsList(OrderItem item) {
  return Column(
    children: [
      _divider(),
      const SizedBox(height: 6),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: item.modifierOptions?.length ?? 0,
        itemBuilder: (context, optionIndex) {
          final option = item.modifierOptions![optionIndex];
          final optionName = option.name ?? '';
          final optionPrice = option.totalPrice ?? 0;
          final optionQty = option.quantity;

          final priceText = optionPrice > 0 && optionQty > 0
              ? Text(
                  SharedHelper.getNumberFormat((optionPrice / optionQty)),
                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size10),
                )
              : const SizedBox();

          return _infoRow(optionName, priceText);
        },
      ),
      const SizedBox(height: 6),
    ],
  );
}

Widget listOfProduct(OrderDetailsController controller) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: (controller.orderDetails?.orderItems ?? []).length,
    itemBuilder: (context, index) => _orderItemCard(index, controller),
  );
}

Widget orderWidget(OrderDetailsController controller) {
  int orderMethod = controller.orderDetails?.deliveryMethodId ?? 0;

  switch (orderMethod) {
    case 1:
      return _deliveryWidget(controller.orderDetails?.customerAddress);
    case 2:
      return _branchWidget(controller.orderDetails?.orderBranchDetails);
    default:
      return SizedBox();
  }
}

Widget _deliveryWidget(Address? customerAddress) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Align(
            alignment: appLanguage == 'en' ? Alignment.topLeft : Alignment.topRight,
            child: Text(
              "deliveryAddress".tr,
              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16, isBold: true),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${"address".tr} : ${customerAddress?.address ?? ""}",
                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _branchWidget(BranchDetails? branchInfo) {
  if (branchInfo == null) return SizedBox();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppTheme.bgColor,
        borderRadius: AppTheme.bigBorderRadius,
        border: Border.all(color: AppTheme.primaryColor.withOpacity(.15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "callStore".tr,
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
                    ),
                    Row(
                      children: [
                        Text(
                          "branchName".tr,
                          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
                        ),
                        Text(
                          " : ${branchInfo.name ?? ""}",
                          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    String url = "tel://${branchInfo.mobile}";
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border?.all(color: AppTheme.textColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AssetsConsts.phoneIcon, width: Get.width * .075, color: AppTheme.textColor),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: appLanguage == 'en' ? Alignment.topLeft : Alignment.topRight,
              child: Row(
                children: [
                  Text(
                    "",
                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
                  ),
                  Text(
                    ' ${'from'.tr} :',
                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
                  ),
                  Expanded(
                    child: Text(
                      " ${branchInfo.name ?? ""}",
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            AppButton(
              title: "showInMap".tr,
              function: () async {
                String destination = "${branchInfo.latitude},${branchInfo.longitude}";
                String url = "https://www.google.com/maps/place/$destination";
                Uri.parse(url);
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget orderSummary(OrderDetails? order) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppTheme.bgColor,
        borderRadius: AppTheme.bigBorderRadius,
        border: Border.all(color: AppTheme.primaryColor.withOpacity(.15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 2,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'subTotal'.tr,
                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                  ),
                ),
                CurrencyAmountText(
                  amountText: SharedHelper.getNumberFormat(order?.subTotalAmount ?? 0),
                  amountStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                ),
              ],
            ),
            Visibility(
              visible: order?.deliveryMethodId == 1,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'deliveryFee'.tr,
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                    ),
                  ),
                  CurrencyAmountText(
                    amountText: SharedHelper.getNumberFormat(order?.deliveryFeesBeforeDiscount ?? 0),
                    amountStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: (order?.taxAmount ?? 0) > 0 ? true : false,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${'tax'.tr} ( ${SharedHelper.getNumberFormat((order?.tax ?? 0) * 100)}% )',
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                    ),
                  ),
                  CurrencyAmountText(
                    amountText: SharedHelper.getNumberFormat(order?.taxAmount ?? 0),
                    amountStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: (order?.orderDiscountAmount ?? 0) > 0 ? true : false,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'orderDiscount'.tr,
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                        ),
                      ),
                      CurrencyAmountText(
                        amountText: '-${SharedHelper.getNumberFormat(order?.orderDiscountAmount ?? 0)}',
                        amountStyle: AppTheme.textStyle(color: AppTheme.redColor, size: AppTheme.size14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: (order?.deliveryFeesDiscount ?? 0) > 0 ? true : false,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'deliveryDiscount'.tr,
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                        ),
                      ),
                      CurrencyAmountText(
                        amountText: '-${SharedHelper.getNumberFormat(order?.deliveryFeesDiscount ?? 0)}',
                        amountStyle: AppTheme.textStyle(color: AppTheme.redColor, size: AppTheme.size14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: (order?.redemptionAmount ?? 0) > 0 ? true : false,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'redeemPoints'.tr,
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                    ),
                  ),
                  CurrencyAmountText(
                    amountText: '-${SharedHelper.getNumberFormat(order?.redemptionAmount ?? 0)}',
                    amountStyle: AppTheme.textStyle(color: AppTheme.redColor, size: AppTheme.size14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _divider(),
            if ((order?.usedWalletAmount ?? 0) > 0) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      order?.paymentMethodName ?? "",
                      style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
                    ),
                  ),
                  CurrencyAmountText(
                    amountText: SharedHelper.getNumberFormat((order?.totalAmount ?? 0) - (order?.usedWalletAmount ?? 0)),
                    amountStyle: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'wallet'.tr,
                      style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
                    ),
                  ),
                  CurrencyAmountText(
                    amountText: SharedHelper.getNumberFormat(order?.usedWalletAmount ?? 0),
                    amountStyle: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _divider(),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'finalAmount'.tr,
                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                  ),
                ),
                CurrencyAmountText(
                  amountText: SharedHelper.getNumberFormat(order?.totalAmount ?? 0),
                  amountStyle: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
