import 'package:my_custom_widget/core/api/api_response.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entities/branch_details.dart';
import '../../domain/entities/closest_branches.dart';
import '../models/branch_details_model.dart';
import '../models/closest_branch_model.dart';

abstract class BranchApiDataSource {
  Future<BranchDetails?> getBranchDetails({Map<String, dynamic>? queryParameters});

  Future<ClosestBranches?> getClosestBranches({required Map<String, dynamic> body});

  Future<dynamic> checkInCustomer({Map<String, dynamic>? queryParameters});
}

class BranchApiDataSourceImpl implements BranchApiDataSource {
  @override
  Future<BranchDetails?> getBranchDetails({Map<String, dynamic>? queryParameters}) async {
    BranchDetails? brandDetails = await ApiRequest<BranchDetails?>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getBranchDetails,
      queryParameters: queryParameters,
      body: {},
      fromJson: BranchDetailsModel.fromJson,
    );
    return brandDetails;
  }

  @override
  Future<ClosestBranches?> getClosestBranches({required Map<String, dynamic> body}) async {
    ClosestBranches? closestBranches = await ApiRequest<ClosestBranches?>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getClosestBranches,
      body: body,
      authorized: true,
      fromJson: ClosestBranchesModel.fromJson,
    );
    return closestBranches ?? const ClosestBranches(withinTheRangeBranches: [], outSideTheRangeBranch: BranchDetails(), totalNumberOfResult: 0);
  }

  @override
  Future checkInCustomer({Map<String, dynamic>? queryParameters}) async {
    dynamic checkInCustomer = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.checkInCustomer,
      body: {},
      queryParameters: queryParameters,
      authorized: true,
      fromJson: getDynamic,
    );
    return checkInCustomer;
  }
}
