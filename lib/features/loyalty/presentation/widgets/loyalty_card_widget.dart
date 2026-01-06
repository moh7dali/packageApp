// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_custom_widget/features/loyalty/presentation/getx/points_controller.dart';
// import 'package:my_custom_widget/shared/helper/shared_helper.dart';
//
// import '../../../../core/utils/theme.dart';
// import '../pages/point_schema_page.dart';
//
// class LoyaltyCardWidget extends StatelessWidget {
//   const LoyaltyCardWidget({super.key, required this.controller});
//
//   final UserBalanceHistoryController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       width: Get.width * .95,
//       decoration: BoxDecoration(
//         color: AppTheme.accentColor,
//         borderRadius: AppTheme.borderRadius,
//         border: Border.all(color: AppTheme.primaryColor.withOpacity(.2), width: 2),
//         boxShadow: [
//           BoxShadow(
//             color: AppTheme.primaryColor.withOpacity(.4),
//             blurRadius: 5,
//             blurStyle: BlurStyle.outer,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(width: 30),
//                 Expanded(
//                   child: Center(
//                     child: Directionality(
//                       textDirection: TextDirection.ltr,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             (controller.currentTier ?? "silver".tr).toUpperCase().tr,
//                             style: AppTheme.textStyle(
//                               color: getTierColor(controller.userLoyaltyData?.loyaltyData?.currentTier ?? 0, controller),
//                               size: AppTheme.size18,
//                               isBold: true,
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             "tier".tr.toUpperCase(),
//                             style: AppTheme.textStyle(
//                               color: getTierColor(controller.userLoyaltyData?.loyaltyData?.currentTier ?? 0, controller),
//                               size: AppTheme.size18,
//                               isBold: true,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     SharedHelper().scaleDialog(PointSchemaPage());
//                   },
//                   child: Icon(
//                     Icons.info_outline,
//                     size: 24,
//                     color: AppTheme.primaryColor,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           "${'balance'.tr} ${SharedHelper.getNumberFormat(controller.userLoyaltyData?.loyaltyData?.pointsBalance ?? 0)}",
//                           style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                             "${'worth'.tr} ${SharedHelper.getNumberFormat(controller.userLoyaltyData?.loyaltyData?.cashBalance ?? 0)} ${'jd'.tr}",
//                             style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
//                             textAlign: TextAlign.center),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             if ((controller.userLoyaltyData?.loyaltyData?.currentTier != 1))
//               Text("${'validUntil'.tr} ${SharedHelper.dateFormatToString(controller.userLoyaltyData?.loyaltyData?.tierExpiryDate ?? DateTime.now())}",
//                   style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12)),
//             const SizedBox(
//               height: 5,
//             ),
//             if ((controller.userLoyaltyData?.loyaltyData?.currentTier ?? 0) < (controller.userLoyaltyData?.tiers?.length ?? 0))
//               Row(
//                 children: [
//                   Expanded(child: getNextTier((controller.userLoyaltyData?.loyaltyData?.currentTier ?? 0), controller)),
//                 ],
//               ),
//             const SizedBox(
//               height: 5,
//             ),
//             Row(
//               children: [
//                 Expanded(child: getMaintainingAmountText((controller.userLoyaltyData?.loyaltyData?.currentTier ?? 0), controller)),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: AppTheme.accentColor,
//                 borderRadius: AppTheme.borderRadius,
//                 border: Border.all(color: AppTheme.primaryColor.withOpacity(.2), width: 2),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppTheme.primaryColor.withOpacity(.4),
//                     blurRadius: 5,
//                     blurStyle: BlurStyle.outer,
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: Column(
//                       children: [
//                         Text("points".tr, style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true)),
//                         Text(
//                           "${controller.userLoyaltyData?.loyaltyData?.pointsBalance ?? 0}",
//                           style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
//                         )
//                       ],
//                     )),
//                     Container(
//                       width: 1,
//                       color: AppTheme.primaryColor,
//                       height: 25,
//                     ),
//                     Expanded(
//                         child: Column(
//                       children: [
//                         Text("earned".tr, style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true)),
//                         Text(
//                           "${controller.userLoyaltyData?.loyaltyData?.addedPoints ?? 0}",
//                           style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
//                         )
//                       ],
//                     )),
//                     Container(
//                       width: 1,
//                       color: AppTheme.primaryColor,
//                       height: 25,
//                     ),
//                     Expanded(
//                         child: Column(
//                       children: [
//                         Text("burned".tr, style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true)),
//                         Text("${controller.userLoyaltyData?.loyaltyData?.redeemedPoints ?? 0}",
//                             style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true)),
//                       ],
//                     )),
//                     Container(
//                       width: 1,
//                       color: AppTheme.primaryColor,
//                       height: 25,
//                     ),
//                     Expanded(
//                         child: Column(
//                       children: [
//                         Text("expired".tr, style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true)),
//                         Text(
//                           "${controller.userLoyaltyData?.loyaltyData?.expiredPoints ?? 0}",
//                           style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
//                         )
//                       ],
//                     )),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Color getTierColor(int currentTier, UserBalanceHistoryController controller) {
//   String color = controller.tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["gradient"] ?? "ffffff";
//   return AppTheme.fromHex(color);
// }
//
// Widget getNextTier(int currentTier, UserBalanceHistoryController controller) {
//   return RichText(
//     textAlign: TextAlign.center,
//     textDirection: TextDirection.ltr,
//     text: TextSpan(
//       text: "spend".tr,
//       style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12),
//       children: [
//         TextSpan(
//             text: " ${getRemaining(currentTier, controller)} ${"jd".tr}",
//             style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12)),
//         TextSpan(text: ' ${'toReach'.tr} ', style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12)),
//         TextSpan(
//             text: '${controller.nextTier}',
//             style: AppTheme.textStyle(
//                 color: AppTheme.fromHex(
//                     controller.userLoyaltyData?.tiers?.firstWhereOrNull((element) => element.id == (currentTier + 1))?.tierColor ??
//                         AppTheme.primaryColorString),
//                 size: AppTheme.size12,
//                 isBold: true)),
//       ],
//     ),
//   );
// }
//
// Widget getMaintainingAmountText(int currentTier, UserBalanceHistoryController controller) {
//   return getMaintainingAmount(currentTier, controller) != null
//       ? RichText(
//           textAlign: TextAlign.center,
//           textDirection: TextDirection.ltr,
//           text: TextSpan(
//             text: "spend".tr,
//             style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12),
//             children: [
//               TextSpan(
//                   text: " ${getMaintainingAmount(currentTier, controller)} ${"jd".tr}",
//                   style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12)),
//               TextSpan(text: ' ${'toStayIn'.tr} ', style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12)),
//               TextSpan(
//                   text: '${controller.currentTier}', style: AppTheme.textStyle(color: getTierColor(currentTier, controller), size: AppTheme.size12)),
//             ],
//           ),
//         )
//       : Container();
// }
//
// String getRemaining(int currentTier, UserBalanceHistoryController controller) {
//   double max = controller.tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["max"];
//   double min = controller.tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["lower"];
//   double tierAmount = controller.userLoyaltyData?.loyaltyData?.tierAmount ?? 0;
//   return SharedHelper.getNumberFormat((max - (min + tierAmount)));
// }
//
// String? getMaintainingAmount(int currentTier, UserBalanceHistoryController controller) {
//   double maintainingAmount = controller.tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["maintainingAmount"] ?? 0;
//   double tierAmount = controller.userLoyaltyData?.loyaltyData?.tierAmount ?? 0;
//   if (maintainingAmount > tierAmount) {
//     return SharedHelper.getNumberFormat(maintainingAmount - tierAmount);
//   } else {
//     return null;
//   }
// }
