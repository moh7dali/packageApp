import 'package:mozaic_loyalty_sdk/features/branch/domain/entities/closest_branches.dart';

import '../../domain/entities/branch_details.dart';
import 'branch_details_model.dart';

class ClosestBranchesModel extends ClosestBranches {
  const ClosestBranchesModel({required super.withinTheRangeBranches, required super.outSideTheRangeBranch, required super.totalNumberOfResult});

  factory ClosestBranchesModel.fromJson(Map<String, dynamic> json) => ClosestBranchesModel(
      totalNumberOfResult: json["TotalNumberofResult"],
      outSideTheRangeBranch: json["OutSideTheRangeBranch"] == null ? null : BranchDetailsModel.fromJson(json["OutSideTheRangeBranch"]),
      withinTheRangeBranches: json["WithinTheRangeBranches"] == null
          ? []
          : List<BranchDetails>.from(json["WithinTheRangeBranches"]!.map((x) => BranchDetailsModel.fromJson(x))));
}
