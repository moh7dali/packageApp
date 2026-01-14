import 'package:mozaic_loyalty_sdk/features/home/data/models/slider_model.dart';

import '../../domain/entities/slider.dart';
import '../../domain/entities/slider_list.dart';

class SliderListModel extends SliderList {
  const SliderListModel({
    required super.sliders,
    required super.totalNumberOfResult,
  });

  factory SliderListModel.fromJson(Map<String, dynamic> json) => SliderListModel(
        totalNumberOfResult: json["TotalNumberOfResult"],
        sliders: json["List"] == null ? [] : List<Slider>.from(json["List"]!.map((x) => SliderModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "TotalNumberOfResult": totalNumberOfResult,
        "List": sliders,
      };
}
