import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';

import '../../../../core/utils/theme.dart';

class PickupBranchCard extends StatelessWidget {
  const PickupBranchCard({super.key, this.selectedBranch, required this.onChangeTap});

  final BranchDetails? selectedBranch;
  final VoidCallback onChangeTap;

  @override
  Widget build(BuildContext context) {
    final hasBranch = selectedBranch != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: AppTheme.bigBorderRadius,
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.22)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 18, offset: const Offset(0, 10))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(.10),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(.16)),
                    ),
                    child: Icon(Icons.store_mall_directory_outlined, color: AppTheme.primaryColor, size: 22),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${"pickUpFrom".tr}: ",
                          style: AppTheme.textStyle(color: AppTheme.primaryColor.withOpacity(.4), size: AppTheme.size12, isBold: true),
                        ),
                        Expanded(
                          child: Text(
                            selectedBranch?.name ?? "noBranchSelected".tr,
                            style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12, isBold: true),
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: onChangeTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.12)),
                      ),
                      child: Text(
                        hasBranch ? "change".tr : "select".tr,
                        style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12, isBold: true),
                      ),
                    ),
                  ),
                ],
              ),
              // if (openTime != null && closeTime != null) ...[
              //   const SizedBox(height: 10),
              //   Row(
              //     children: [
              //       Expanded(
              //         child: Container(
              //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              //           decoration: BoxDecoration(
              //             color: AppTheme.primaryColor.withOpacity(.06),
              //             borderRadius: BorderRadius.circular(16),
              //             border: Border.all(color: AppTheme.primaryColor.withOpacity(.12)),
              //           ),
              //           child: Row(
              //             children: [
              //               Icon(Icons.access_time_rounded, color: AppTheme.primaryColor, size: 18),
              //               const SizedBox(width: 8),
              //               Expanded(
              //                 child: Text(
              //                   "${SharedHelper().formatDuration(time: openTime)} - ${SharedHelper().formatDuration(time: closeTime)}",
              //                   style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12, isBold: true),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       if (mobile != null && mobile!.trim().isNotEmpty) ...[
              //         const SizedBox(width: 10),
              //         GestureDetector(
              //           onTap: () async {
              //             await launchUrl(Uri.parse("tel:${AppConstants.countryCode}$mobile"), mode: LaunchMode.externalApplication);
              //           },
              //           child: Container(
              //             width: 44,
              //             height: 44,
              //             decoration: BoxDecoration(
              //               color: AppTheme.primaryColor.withOpacity(.10),
              //               shape: BoxShape.circle,
              //               border: Border.all(color: AppTheme.primaryColor.withOpacity(.16)),
              //             ),
              //             child: Icon(Icons.call_rounded, color: AppTheme.primaryColor, size: 20),
              //           ),
              //         ),
              //       ],
              //     ],
              //   ),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
