import 'package:flutter/material.dart';

import '../../../../core/utils/theme.dart';
import '../../domain/entity/business_unit_Loyalty_data.dart';

class DropDownShemaByBusinessUnit extends StatefulWidget {
  DropDownShemaByBusinessUnit({required this.businessUnitLoyaltyDataList, required this.selectedBusinessUnit});

  List<BusinessUnitLoyaltyData>? businessUnitLoyaltyDataList;
  BusinessUnitLoyaltyData? selectedBusinessUnit;

  @override
  State<DropDownShemaByBusinessUnit> createState() => _DropDownSchemaState();
}

class _DropDownSchemaState extends State<DropDownShemaByBusinessUnit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButton<BusinessUnitLoyaltyData>(
              icon: Icon(Icons.keyboard_arrow_down, color: AppTheme.primaryColor),
              isExpanded: true,
              underline: SizedBox(),
              value: widget.selectedBusinessUnit,
              items: widget.businessUnitLoyaltyDataList!.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.businessUnitName ?? "",
                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.selectedBusinessUnit = value!;
                });
              },
            ),
            Divider(
              color: AppTheme.primaryColor,
              thickness: 1,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.selectedBusinessUnit!.tiersLoyaltyDataList?.length ?? 0,
              itemBuilder: (context, index3) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.selectedBusinessUnit!.tiersLoyaltyDataList![index3].brandName}",
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16)),
                      Text(
                          (double.parse(widget.selectedBusinessUnit!.tiersLoyaltyDataList![index3].conversionValue.toString()) * 100) % 1 == 0
                              ? (double.parse(widget.selectedBusinessUnit!.tiersLoyaltyDataList![index3].conversionValue.toString()) * 100)
                                  .toStringAsFixed(0)
                              : (double.parse(widget.selectedBusinessUnit!.tiersLoyaltyDataList![index3].conversionValue.toString()) * 100)
                                  .toStringAsFixed(1),
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16)),
                    ],
                  ),
                );
              },
            ),
            Divider(
              color: AppTheme.primaryColor,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
