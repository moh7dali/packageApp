import 'package:flutter/material.dart';
import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';

import '../../../../core/utils/theme.dart';
import '../getx/selected_order_method_controller.dart';

class BranchWidget extends StatelessWidget {
  const BranchWidget({super.key, required this.branch, required this.onTap, required this.controller});

  final BranchDetails branch;
  final Function() onTap;
  final SelectedOrderMethodController controller;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = controller.selectedBranch?.id == branch.id;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor.withOpacity(0.95) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: isSelected ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(0.15), width: isSelected ? 1.5 : 1),
            boxShadow: [
              BoxShadow(
                color: isSelected ? AppTheme.primaryColor.withOpacity(0.35) : Colors.black.withOpacity(0.06),
                blurRadius: isSelected ? 16 : 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.whiteColor.withOpacity(.15) : AppTheme.primaryColor.withOpacity(.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    isSelected ? Icons.check_circle_rounded : Icons.store_mall_directory_outlined,
                    color: isSelected ? AppTheme.whiteColor : AppTheme.primaryColor,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    branch.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.textStyle(color: isSelected ? AppTheme.whiteColor : AppTheme.textColor, size: AppTheme.size14, isBold: true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
