import 'package:mozaic_loyalty_sdk/features/home/data/models/tier_model.dart';

import '../../domain/entities/tier.dart';
import '../../domain/entities/tiers_list.dart';

class TiersListModel extends TiersList {
  const TiersListModel({
    required super.tiers,
    required super.totalNumberOfResult,
  });

  factory TiersListModel.fromJson(Map<String, dynamic> json) => TiersListModel(
        totalNumberOfResult: json["TotalNumberOfResult"],
        tiers: json["List"] == null ? [] : List<TiersData>.from(json["List"]!.map((x) => TierModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "TotalNumberOfResult": totalNumberOfResult,
        "Tiers": tiers,
      };
}
