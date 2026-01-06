import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/api/api_response.dart';
import '../../../../core/constants/constants.dart';

abstract class RateApiDataSource {
  Future<dynamic> rateBranchVisit({required Map<String, dynamic> body});
}

class RateApiDataSourceImpl extends RateApiDataSource {
  @override
  Future rateBranchVisit({required Map<String, dynamic> body}) async {
    dynamic rateBranchVisitApi = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.rateBranchVisit,
      body: body,
      authorized: true,
      fromJson: getDynamic,
    );
    return rateBranchVisitApi;
  }
}
