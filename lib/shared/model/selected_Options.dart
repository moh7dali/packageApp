import '../../features/category/data/models/product_details_model.dart';
import '../../features/category/domain/entities/product_details.dart';

class SelectedModifierOption {
  final ProductModifier modifier;
  final dynamic selectedOption;

  SelectedModifierOption({required this.modifier, required this.selectedOption});
}

class SelectedModifierOptionModel extends SelectedModifierOption {
  SelectedModifierOptionModel({required super.modifier, required super.selectedOption});

  factory SelectedModifierOptionModel.fromJson(Map<String, dynamic> json) {
    final modifier = ProductModifierModel.fromJson(json['modifier']);
    final selectedOptionJson = json['selectedOption'];

    final selectedOption = modifier.type == 1
        ? (selectedOptionJson as List).map((e) => ModifierOptionModel.fromJson(e)).toList()
        : ModifierOptionModel.fromJson(selectedOptionJson);

    return SelectedModifierOptionModel(
      modifier: modifier,
      selectedOption: selectedOption,
    );
  }

  Map<String, dynamic> toJson() => {
        'modifier': ProductModifierModel.fromEntity(modifier).toJson(),
        'selectedOption': modifier.type == 1
            ? (selectedOption as List<ModifierOptionModel>).map((e) => e.toJson()).toList()
            : (selectedOption as ModifierOptionModel).toJson(),
      };

  factory SelectedModifierOptionModel.fromEntity(SelectedModifierOption entity) {
    return SelectedModifierOptionModel(
      modifier: ProductModifierModel.fromEntity(entity.modifier),
      selectedOption: entity.modifier.type == 1
          ? (entity.selectedOption as List<ModifierOption>).map((e) => ModifierOptionModel.fromEntity(e)).toList()
          : ModifierOptionModel.fromEntity(entity.selectedOption as ModifierOption),
    );
  }
}
