import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/api/api_response.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entity/invite_friend.dart';
import '../../domain/entity/merchant_info.dart';
import '../../domain/entity/profile_info.dart';
import '../models/invite_friends_model.dart';
import '../models/merchant_info_model.dart';
import '../models/profile_info_model.dart';

abstract class MenuApiDataSource {
  Future<ProfileInfo> getProfileInfo();

  Future<InviteFriends> getSystemResource({required Map<String, dynamic> body});

  Future<MerchantInfo> getMerchantContactInfo({required Map<String, dynamic> body});

  Future<dynamic> deleteAccount();

  Future<dynamic> logOut();
}

class MenuApiDataSourceImpl implements MenuApiDataSource {
  @override
  Future<ProfileInfo> getProfileInfo() async {
    ProfileInfo profileInfo = await ApiRequest<ProfileInfo>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getProfile,
      body: {},
      authorized: true,
      fromJson: ProfileInfoModel.fromJson,
    );
    return profileInfo;
  }

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

  @override
  Future deleteAccount() async {
    dynamic deleteAccount = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.deleteProfile,
      body: {},
      authorized: true,
      fromJson: getDynamic,
    );
    return deleteAccount;
  }

  @override
  Future logOut() async {
    dynamic logout = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.logout,
      body: {},
      authorized: true,
      fromJson: getDynamic,
    );
    return logout;
  }
}
