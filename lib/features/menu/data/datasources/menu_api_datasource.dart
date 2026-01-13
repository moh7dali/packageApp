import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entity/invite_friend.dart';
import '../../domain/entity/merchant_info.dart';
import '../models/invite_friends_model.dart';
import '../models/merchant_info_model.dart';

abstract class MenuApiDataSource {
  Future<InviteFriends> getSystemResource({required Map<String, dynamic> body});

  Future<MerchantInfo> getMerchantContactInfo({required Map<String, dynamic> body});
}

class MenuApiDataSourceImpl implements MenuApiDataSource {
  @override
  Future<InviteFriends> getSystemResource({required Map<String, dynamic> body}) async {
    InviteFriends? inviteFriends = await ApiRequest<InviteFriends?>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getSystemResource,
      body: {},
      queryParameters: body,
      authorized: true,
      fromJson: InviteFriendsModel.fromJson,
    );
    return inviteFriends ?? const InviteFriends(value: '');
  }

  @override
  Future<MerchantInfo> getMerchantContactInfo({required Map<String, dynamic> body}) async {
    MerchantInfo merchantInfo = await ApiRequest<MerchantInfo>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getMerchantContactInfo,
      body: {},
      queryParameters: body,
      fromJson: MerchantInfoModel.fromJson,
    );
    return merchantInfo;
  }
}
