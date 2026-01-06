import 'package:get/get.dart';

import '../../../../injection_container.dart'; // for sl()
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../../category/domain/usecases/get_category_filters.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/filters.dart';

class FiltersController extends GetxController {
  final GetCategoryFilters getCategoryFilters;

  FiltersController() : getCategoryFilters = sl();

  List<Filter> filters = [];

  final Map<int, Set<int>> _selectedOptionIdsByFilterId = {};

  final Set<int> _selectedType3FilterIds = {};

  final Map<int, String> _typedValuesByFilterId = {};

  final Set<int> expandedFilterIds = {};

  bool isFilterExpanded(int filterId) => expandedFilterIds.contains(filterId);

  bool isType3Selected(int filterId) => _selectedType3FilterIds.contains(filterId);

  bool isOptionSelected(int filterId, int optionId) {
    final set = _selectedOptionIdsByFilterId[filterId];
    if (set == null) return false;
    return set.contains(optionId);
  }

  int? selectedRadioOptionId(int filterId) {
    final set = _selectedOptionIdsByFilterId[filterId];
    if (set == null || set.isEmpty) return null;
    return set.first;
  }

  String getType4Value(int filterId) => _typedValuesByFilterId[filterId] ?? '';

  void toggleExpand(int filterId) {
    if (expandedFilterIds.contains(filterId)) {
      expandedFilterIds.remove(filterId);
    } else {
      expandedFilterIds.add(filterId);
    }
    update();
  }

  void toggleType3(Filter filter, bool value) {
    final fid = filter.id ?? -1;
    if (value) {
      _selectedType3FilterIds.add(fid);
    } else {
      _selectedType3FilterIds.remove(fid);
    }
    update();
  }

  void toggleType2Option(Filter filter, int optionId, bool value) {
    final fid = filter.id ?? -1;
    final set = _selectedOptionIdsByFilterId.putIfAbsent(fid, () => <int>{});
    if (value) {
      set.add(optionId);
    } else {
      set.remove(optionId);
      if (set.isEmpty) _selectedOptionIdsByFilterId.remove(fid);
    }
    update();
  }

  void selectRadio(Filter filter, int optionId) {
    final fid = filter.id ?? -1;
    _selectedOptionIdsByFilterId[fid] = {optionId};
    update();
  }

  void setType4Value(Filter filter, String value) {
    final fid = filter.id ?? -1;
    _typedValuesByFilterId[fid] = value;
  }

  void commitType4(Filter filter) {
    update();
  }

  List<Filter> buildSelectedFilters() {
    final List<Filter> result = [];

    for (final f in filters) {
      final fid = f.id ?? -1;

      if (f.type == 3) {
        if (_selectedType3FilterIds.contains(fid)) {
          result.add(_cloneFilterWithOptions(f, const []));
        }
        continue;
      }

      if (f.type == 4) {
        final val = _typedValuesByFilterId[fid];
        if (val != null && val.isNotEmpty) {
          final typedOption = FilterOption(id: -1, value: val, label: val, minValue: 0, maxValue: 0);
          result.add(_cloneFilterWithOptions(f, [typedOption]));
        }
        continue;
      }

      final selectedIds = _selectedOptionIdsByFilterId[fid];
      if (selectedIds != null && selectedIds.isNotEmpty) {
        final selectedOptions = (f.filterOptions ?? []).where((o) => selectedIds.contains(o.id)).toList();
        result.add(_cloneFilterWithOptions(f, selectedOptions));
      }
    }

    return result;
  }

  Filter _cloneFilterWithOptions(Filter src, List<FilterOption> opts) {
    return Filter(id: src.id, name: src.name, type: src.type, isActive: src.isActive, filterOptions: opts);
  }

  Future<PaginationListModel> getFiltersApi({int page = 1, required Category selectedCategory}) async {
    filters = [];
    int totalNumberOfResult = 0;

    await getCategoryFilters.repository
        .getCategoryFilters(queryParameters: {"pageNumber": "$page", "id": "${selectedCategory.id}"})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (list) {
              filters = list.list ?? [];
              totalNumberOfResult = list.totalNumberOfResult ?? 0;
              update();
            },
          ),
        );

    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: filters);
  }

  getSelectedFilters() {
    print("Selected filters: ${buildSelectedFilters()}");
  }

  bool get hasSelections {
    final hasType1or2or5 = _selectedOptionIdsByFilterId.values.any((s) => s.isNotEmpty);
    final hasType3 = _selectedType3FilterIds.isNotEmpty;
    final hasType4 = _typedValuesByFilterId.values.any((v) => (v).trim().isNotEmpty);
    return hasType1or2or5 || hasType3 || hasType4;
  }

  int selectedCount() {
    int c = 0;
    c += _selectedType3FilterIds.length;
    c += _selectedOptionIdsByFilterId.values.fold(0, (p, s) => p + s.length);
    c += _typedValuesByFilterId.values.where((v) => v.trim().isNotEmpty).length;
    return c;
  }

  void clearAllSelections() {
    _selectedOptionIdsByFilterId.clear();
    _selectedType3FilterIds.clear();
    _typedValuesByFilterId.clear();
    update();
  }

  void clearFilter(Filter f) {
    final fid = f.id ?? -1;
    _selectedOptionIdsByFilterId.remove(fid);
    _selectedType3FilterIds.remove(fid);
    _typedValuesByFilterId.remove(fid);
    update();
  }
}
