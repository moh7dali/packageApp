import 'package:equatable/equatable.dart';

import 'branch_details.dart';

class ClosestBranches extends Equatable {
  final List<BranchDetails>? withinTheRangeBranches;
  final BranchDetails? outSideTheRangeBranch;
  final int? totalNumberOfResult;

  const ClosestBranches({required this.withinTheRangeBranches, required this.outSideTheRangeBranch, required this.totalNumberOfResult});

  @override
  List<Object?> get props => [withinTheRangeBranches, outSideTheRangeBranch, totalNumberOfResult];
}
