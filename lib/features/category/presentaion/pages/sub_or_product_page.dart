import 'package:my_custom_widget/features/category/presentaion/getx/sub_or_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../../home/presentation/widget/curved.dart';
import '../../../ordering/presentation/widget/cart_icon_widget.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/filters.dart';
import '../widgets/loading_horizontal.dart';
import '../widgets/product_list_widget.dart';
import '../widgets/sub_category_list_widget.dart';

class SubOrProductPage extends StatelessWidget {
  const SubOrProductPage({super.key, required this.selectedCategory, required this.parentCategoryList, this.sliderCategoryId});

  final Category selectedCategory;
  final List<Category> parentCategoryList;
  final int? sliderCategoryId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubOrProductController>(
      init: SubOrProductController(parentCategoryList: parentCategoryList, selectedCategory: selectedCategory, sliderCategoryId: sliderCategoryId),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppTheme.bgColor,
          appBar: AppBar(backgroundColor: AppTheme.bgColor, title: Text(controller.selectedCategory.name ?? ""), actions: [CartIconWidget()]),
          body: RefreshIndicator(
            color: AppTheme.primaryColor,
            onRefresh: () async {
              controller.changeTab(controller.selectedCategory);
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  CurvedCategoryScroller(
                    items: parentCategoryList,
                    selectedCategoryId: controller.selectedCategory.id,
                    onTap: (category) {
                      controller.changeTab(category);
                    },
                  ),
                  if (controller.selectedCategory.hasFilters ?? false) ...[
                    controller.isFilterLoading
                        ? LoadingInHorizontal()
                        : PaginationListView<Filter>(
                            isHorizontal: true,
                            horizontalHeight: controller.availableFilters.isEmpty ? 0 : Get.height * .065,
                            loadFirstList: () async => await controller.getFiltersApi(page: 1, selectedCategory: controller.selectedCategory),
                            loadMoreList: (page) async => await controller.getFiltersApi(page: page, selectedCategory: controller.selectedCategory),
                            itemBuilder: (context, f) {
                              final isSelected = controller.isFilterSelected(f);
                              return GestureDetector(
                                onTap: () => _openFilterSheet(controller, f),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: isSelected ? AppTheme.primaryColor : AppTheme.bgThemeColor,
                                    border: Border.all(color: isSelected ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(.15)),
                                    boxShadow: [
                                      if (isSelected)
                                        BoxShadow(color: AppTheme.primaryColor.withOpacity(.25), blurRadius: 10, offset: const Offset(0, 4)),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        isSelected ? Icons.check_circle : Icons.tune,
                                        size: 16,
                                        color: isSelected ? AppTheme.accentColor : AppTheme.primaryColor,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        f.name ?? '-',
                                        style: AppTheme.textStyle(
                                          size: AppTheme.size14,
                                          color: isSelected ? AppTheme.accentColor : AppTheme.textColor,
                                          isBold: isSelected,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },

                            emptyWidget: Container(),
                            emptyText: "",
                            loadingWidget: LoadingInHorizontal(),
                          ),
                    const SizedBox(height: 8),
                    controller.selectedFilters.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(.05), borderRadius: AppTheme.bigBorderRadius),
                              child: Row(
                                children: [
                                  TextButton.icon(
                                    onPressed: controller.clearAllSelectedFilters,
                                    icon: const Icon(Icons.clear_all, color: AppTheme.redColor),
                                    label: Text(
                                      "clearAll".tr,
                                      style: AppTheme.textStyle(color: AppTheme.redColor, size: AppTheme.size14, isBold: true),
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: controller.selectedFilters.expand((f) {
                                          final opts = f.filterOptions ?? const <FilterOption>[];

                                          List<Widget> chips = [];

                                          if (f.type == 3) {
                                            chips.add(_selectedChip(label: f.name ?? '-', onRemove: () => controller.removeOneSelection(f, null)));
                                          } else if (f.type == 4 && opts.isNotEmpty) {
                                            chips.add(
                                              _selectedChip(
                                                label: controller.optionLabel(f, opts.first),
                                                onRemove: () => controller.removeOneSelection(f, opts.first),
                                              ),
                                            );
                                          } else {
                                            chips.addAll(
                                              opts.map(
                                                (o) => _selectedChip(
                                                  label: controller.optionLabel(f, o),
                                                  onRemove: () => controller.removeOneSelection(f, o),
                                                ),
                                              ),
                                            );
                                          }

                                          return chips;
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      controller.selectedCategory.name ?? "",
                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size20, isBold: true),
                    ),
                  ),
                  controller.isLoading
                      ? Container()
                      : (controller.selectedCategory.hasSubcategory ?? false)
                      ? SubCategoryListWidget(
                          controller: controller,
                          selectedCategory: controller.selectedCategory,
                          scrollController: controller.scrollController,
                        )
                      : ProductListWidget(
                          controller: controller,
                          selectedCategory: controller.selectedCategory,
                          scrollController: controller.scrollController,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _selectedChip({required String label, required VoidCallback onRemove}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Chip(
        label: Text(
          label,
          style: AppTheme.textStyle(size: AppTheme.size12, color: AppTheme.primaryColor),
        ),
        deleteIcon: const Icon(Icons.close, size: 16),
        onDeleted: onRemove,
        backgroundColor: AppTheme.bgThemeColor,
        shape: StadiumBorder(side: BorderSide(color: AppTheme.primaryColor.withOpacity(.25))),
      ),
    );
  }

  void _openFilterSheet(SubOrProductController controller, Filter filter) {
    final currentIdx = controller.selectedFilters.indexWhere((x) => x.id == filter.id);
    final current = currentIdx == -1 ? null : controller.selectedFilters[currentIdx];
    final currentOptions = List<FilterOption>.from(current?.filterOptions ?? const []);

    final TextEditingController textCtrl = TextEditingController(
      text: (filter.type == 4 && currentOptions.isNotEmpty) ? (currentOptions.first.value?.toString() ?? '') : '',
    );
    bool type3Checked = (filter.type == 3) && (current != null);

    SharedHelper().bottomSheet(
      Padding(
        padding: EdgeInsets.all(16),
        child: StatefulBuilder(
          builder: (context, setState) {
            Widget body;
            switch (filter.type) {
              case 1:
              case 5:
                {
                  final opts = filter.filterOptions ?? const <FilterOption>[];
                  int? singleSelectedId = (currentOptions.isNotEmpty) ? currentOptions.first.id : null;
                  body = ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        filter.name ?? '-',
                        style: AppTheme.textStyle(size: AppTheme.size16, color: AppTheme.textColor),
                      ),
                      const SizedBox(height: 8),
                      ...opts.map((o) {
                        return RadioListTile<int>(
                          value: o.id ?? -1,
                          groupValue: singleSelectedId,
                          title: Text(controller.optionLabel(filter, o)),
                          onChanged: (v) {
                            setState(() {
                              singleSelectedId = v;
                              currentOptions
                                ..clear()
                                ..add(o);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        );
                      }),
                      const SizedBox(height: 8),
                    ],
                  );
                  break;
                }

              // ---------- TOGGLE (boolean) ----------
              case 3:
                {
                  body = Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              filter.name ?? '-',
                              style: AppTheme.textStyle(size: AppTheme.size16, color: AppTheme.textColor),
                            ),
                          ),
                          Switch(
                            value: type3Checked,
                            onChanged: (v) => setState(() => type3Checked = v),
                            activeThumbColor: AppTheme.primaryColor,
                            inactiveThumbColor: AppTheme.primaryColor,
                            inactiveTrackColor: AppTheme.primaryColor.withOpacity(.1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                  break;
                }

              case 4:
                {
                  body = Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filter.name ?? '-',
                        style: AppTheme.textStyle(size: AppTheme.size16, color: AppTheme.textColor),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: textCtrl,
                        decoration: InputDecoration(
                          hintText: 'enterValue'.tr,
                          border: OutlineInputBorder(borderRadius: AppTheme.borderRadius),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                  break;
                }
              case 2:
                {
                  final opts = filter.filterOptions ?? const <FilterOption>[];
                  body = ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        filter.name ?? '-',
                        style: AppTheme.textStyle(size: AppTheme.size16, color: AppTheme.textColor),
                      ),
                      const SizedBox(height: 8),
                      ...opts.map((o) {
                        final isSelected = currentOptions.any((x) => x.id == o.id && x.value == o.value);
                        return CheckboxListTile(
                          value: isSelected,
                          title: Text(controller.optionLabel(filter, o)),
                          onChanged: (v) {
                            setState(() {
                              if (v == true) {
                                currentOptions.add(o);
                              } else {
                                currentOptions.removeWhere((x) => x.id == o.id && x.value == o.value);
                              }
                            });
                          },
                        );
                      }),
                      const SizedBox(height: 8),
                    ],
                  );
                  break;
                }

              default:
                body = const SizedBox.shrink();
            }

            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  body,
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            controller.applySingleFilterSelection(filter, const [], typedValue: '', includeType3: false);
                            Navigator.pop(context);
                          },
                          child: Text('clearAll'.tr, style: AppTheme.textStyle(color: AppTheme.redColor)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            switch (filter.type) {
                              case 3:
                                controller.applySingleFilterSelection(filter, const [], includeType3: type3Checked);
                                break;
                              case 4:
                                controller.applySingleFilterSelection(filter, const [], typedValue: textCtrl.text);
                                break;
                              case 1:
                              case 2:
                              case 5:
                                controller.applySingleFilterSelection(filter, currentOptions);
                                break;
                              default:
                                break;
                            }
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                          child: Text('apply'.tr, style: AppTheme.textStyle(color: AppTheme.accentColor)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
