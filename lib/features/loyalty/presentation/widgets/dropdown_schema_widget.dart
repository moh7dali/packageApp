import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/core/utils/translate/translation.dart';
import 'package:mozaic_loyalty_sdk/shared/widgets/no_item_widget.dart';

import '../../../../core/utils/theme.dart';
import '../../domain/entity/tiers_loyalty_data.dart';

class DropDownSchema extends StatefulWidget {
  DropDownSchema({super.key, required this.tiersLoyaltyDataList, required this.selectedTiersLoyaltyData});

  List<TiersLoyaltyData>? tiersLoyaltyDataList;
  TiersLoyaltyData? selectedTiersLoyaltyData;

  @override
  State<DropDownSchema> createState() => _DropDownSchemaState();
}

class _DropDownSchemaState extends State<DropDownSchema> {
  @override
  Widget build(BuildContext context) {
    return (widget.tiersLoyaltyDataList ?? []).isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 8),
            physics: const BouncingScrollPhysics(),
            itemCount: widget.tiersLoyaltyDataList?.length ?? 0,
            itemBuilder: (context, index3) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "${widget.tiersLoyaltyDataList?[index3].brandName}",
                            style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
                          ),
                        ),
                        Text(
                          (double.parse(widget.tiersLoyaltyDataList![index3].conversionValue.toString()) * 100) % 1 == 0
                              ? (double.parse(widget.tiersLoyaltyDataList![index3].conversionValue.toString()) * 100).toStringAsFixed(0)
                              : (double.parse(widget.tiersLoyaltyDataList![index3].conversionValue.toString()) * 100).toStringAsFixed(1),
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
                        ),
                      ],
                    ),
                    if (index3 != ((widget.tiersLoyaltyDataList?.length ?? 0) - 1)) Divider(color: AppTheme.primaryColor, thickness: 1),
                  ],
                ),
              );
            },
          );
  }

  Widget _buildEmptyState() {
    return Container(
      decoration: BoxDecoration(color: AppTheme.primaryColor, shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NoItemWidget(),
            Text(
              "somethingWrong".sdkTr,
              style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
            ),
          ],
        ),
      ),
    );
  }
}
