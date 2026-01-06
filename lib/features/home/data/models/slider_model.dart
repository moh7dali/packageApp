import '../../domain/entities/slider.dart';

class SliderModel extends Slider {
  const SliderModel({
    required super.id,
    required super.name,
    required super.sliderType,
    required super.displayOrder,
    required super.sliderItems,
  });

  factory SliderModel.fromMap(Map<String, dynamic> json) => SliderModel(
        id: json["Id"],
        name: json["Name"],
        sliderType: json["SliderType"],
        displayOrder: json["DisplayOrder"],
        sliderItems: json["SliderItems"] == null ? [] : List<SliderItem>.from(json["SliderItems"]!.map((x) => SliderItemsModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Id": id,
        "Name": name,
        "SliderType": sliderType,
        "DisplayOrder": displayOrder,
        "SliderItems": sliderItems,
      };
}

class SliderItemsModel extends SliderItem {
  const SliderItemsModel({
    required super.id,
    required super.name,
    required super.sliderId,
    required super.imageUrl,
    required super.assignTypeId,
    required super.assignmentEntityId,
    required super.assignmentCategoryId,
    required super.brandId,
    required super.displayOrder,
    required super.displayStartDate,
    required super.displayEndDate,
  });

  factory SliderItemsModel.fromMap(Map<String, dynamic> json) => SliderItemsModel(
        id: json["Id"],
        name: json["Name"],
        sliderId: json["SliderId"],
        imageUrl: json["ImageUrl"],
        assignTypeId: json["AssignTypeId"],
        brandId: json["BrandId"],
        displayOrder: json["DisplayOrder"],
        displayStartDate: json["DisplayStartDate"],
        displayEndDate: json["DisplayEndDate"],
        assignmentEntityId: json["AssignmentEntityId"],
        assignmentCategoryId: json["AssignmentCategoryId"],
      );

  Map<String, dynamic> toMap() => {
        "Id": id,
        "Name": name,
        "SliderId": sliderId,
        "ImageUrl": imageUrl,
        "AssignTypeId": assignTypeId,
        "AssignmentEntityId": assignmentEntityId,
        "assignmentCategoryId": assignmentCategoryId,
        "BrandId": brandId,
        "DisplayOrder": displayOrder,
        "DisplayStartDate": displayStartDate,
        "DisplayEndDate": displayEndDate,
      };
}
