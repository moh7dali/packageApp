import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';

import '../../domain/entities/branches_list.dart';
import 'branch_details_model.dart';

class BranchDetailsListModel extends BranchDetailsList {
  const BranchDetailsListModel({
    required super.totalNumberofResult,
    required super.branches,
  });

  factory BranchDetailsListModel.fromJson(Map<String, dynamic> json) => BranchDetailsListModel(
        totalNumberofResult: json["TotalNumberofResult"],
        branches: json["Branches"] == null ? [] : List<BranchDetails>.from(json["Branches"]!.map((x) => BranchDetailsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalNumberofResult": totalNumberofResult,
        "Branches": branches,
      };
}
