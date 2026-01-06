import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../domain/entities/filters.dart';
import '../getx/filters_controller.dart';

class FilterCard extends StatelessWidget {
  const FilterCard({super.key, required this.filter});

  final Filter filter;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FiltersController>(
      builder: (c) {
        final isType3 = (filter.type == 3);
        final isExpanded = c.isFilterExpanded(filter.id ?? -1);
        if (isType3) {
          final checked = c.isType3Selected(filter.id ?? -1);
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: CheckboxListTile(
              title: Text(filter.name ?? '-', style: const TextStyle(fontWeight: FontWeight.w600)),
              value: checked,
              onChanged: (v) => c.toggleType3(filter, v ?? false),
              controlAffinity: ListTileControlAffinity.trailing,
            ),
          );
        }
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            children: [
              InkWell(
                onTap: () => c.toggleExpand(filter.id ?? -1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(filter.name ?? '-', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded) const Divider(height: 1),
              if (isExpanded) _OptionsArea(filter: filter),
            ],
          ),
        );
      },
    );
  }
}

class _OptionsArea extends StatelessWidget {
  const _OptionsArea({required this.filter});

  final Filter filter;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FiltersController>(
      builder: (c) {
        final options = filter.filterOptions ?? const <FilterOption>[];
        if (filter.type == 4) {
          final txt = TextEditingController(text: c.getType4Value(filter.id ?? -1));
          return Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) c.commitType4(filter);
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: txt,
                decoration: InputDecoration(
                  labelText: "Enter value",
                  fillColor: AppTheme.secondaryColor,
                  filled: true,
                  border: AppTheme.outLineBorder,
                  enabledBorder: AppTheme.outLineBorder,
                  focusedBorder: AppTheme.outLineBorder,
                ),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                onChanged: (val) => c.setType4Value(filter, val),
              ),
            ),
          );
        }

        if (filter.type == 1 || filter.type == 5) {
          final groupValue = c.selectedRadioOptionId(filter.id ?? -1);
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 8),
            itemBuilder: (_, idx) {
              final o = options[idx];

              String? subtitle;
              if (filter.type == 5) {
                final minV = o.minValue ?? 0;
                final maxV = o.maxValue ?? 0;
                subtitle = 'Min: ${_fmtNum(minV)}  •  Max: ${_fmtNum(maxV)}';
              }

              return RadioListTile<int>(
                title: Text(o.label ?? o.value ?? '-'),
                subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: Colors.grey)) : null,
                value: o.id ?? -1,
                groupValue: groupValue,
                onChanged: (val) {
                  if (val != null) c.selectRadio(filter, val);
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              );
            },
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemCount: options.length,
          );
        }

        if (filter.type == 2) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 8),
            itemBuilder: (_, idx) {
              final o = options[idx];
              final checked = c.isOptionSelected(filter.id ?? -1, o.id ?? -1);
              return CheckboxListTile(
                title: Text(o.label ?? o.value ?? '-'),
                value: checked,
                onChanged: (v) => c.toggleType2Option(filter, o.id ?? -1, v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              );
            },
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemCount: options.length,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  String _fmtNum(num n) {
    if (n is double) return n.toStringAsFixed(2);
    if (n is int) return n.toString();
    return n.toString();
  }
}

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key, required this.controller});

  final FiltersController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (controller.hasSelections)
                TextButton.icon(
                  onPressed: controller.clearAllSelections,
                  icon: const Icon(Icons.clear_all, color: Colors.red),
                  label: Text(
                    '${"clearAll".tr} (${controller.selectedCount()})',
                    style: AppTheme.textStyle(color: AppTheme.redColor, size: AppTheme.size14),
                  ),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
              SizedBox(
                width: Get.width * .5,
                child: AppButton(
                  title: "filter".tr,
                  isDoneBtn: controller.hasSelections,
                  function: () {
                    final selected = controller.buildSelectedFilters();
                    Get.back(result: selected);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
