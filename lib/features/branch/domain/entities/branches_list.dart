import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';

class BranchDetailsList extends Equatable {
  final int? totalNumberofResult;
  final List<BranchDetails>? branches;

  const BranchDetailsList({
    this.branches,
    this.totalNumberofResult,
  });

  @override
  List<Object?> get props => [branches, totalNumberofResult];
}
