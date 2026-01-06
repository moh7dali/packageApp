import 'package:equatable/equatable.dart';

class Slider extends Equatable {
  final int? id;
  final String? name;
  final int? sliderType;
  final int? displayOrder;
  final List<SliderItem>? sliderItems;

  const Slider({
    this.id,
    this.name,
    this.sliderType,
    this.displayOrder,
    this.sliderItems,
  });

  @override
  List<Object?> get props => [id, name, sliderType, displayOrder, sliderItems];
}

class SliderItem extends Equatable {
  final int? id;
  final String? name;
  final int? sliderId;
  final String? imageUrl;
  final int? assignTypeId;
  final int? assignmentEntityId;
  final int? assignmentCategoryId;
  final int? brandId;
  final int? displayOrder;
  final dynamic displayStartDate;
  final dynamic displayEndDate;

  const SliderItem({
    this.id,
    this.name,
    this.sliderId,
    this.imageUrl,
    this.assignTypeId,
    this.assignmentEntityId,
    this.assignmentCategoryId,
    this.brandId,
    this.displayOrder,
    this.displayStartDate,
    this.displayEndDate,
  });

  @override
  List<Object?> get props =>
      [id, name, sliderId, imageUrl, assignTypeId, brandId, displayOrder, displayStartDate, displayEndDate, assignmentEntityId,assignmentCategoryId];
}
