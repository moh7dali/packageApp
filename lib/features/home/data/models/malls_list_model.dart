import '../../domain/entities/malls.dart';
import '../../domain/entities/malls_list.dart';
import 'malls_model.dart';

class MallsListModel extends MallsList {
  const MallsListModel({
    required super.malls,
    required super.totalNumberOfResult,
  });

  factory MallsListModel.fromJson(Map<String, dynamic> json) => MallsListModel(
        totalNumberOfResult: json["TotalNumberOfResult"],
        malls: json["List"] == null ? [] : List<Malls>.from(json["List"]!.map((x) => MallsModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "TotalNumberOfResult": totalNumberOfResult,
        "List": malls,
      };
}
