import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/helper/shared_preferences_storage.dart';
import '../../domain/usecases/get_system_resource.dart';

class InviteFriendsController extends GetxController {
  final GetSystemResource getSystemResource;

  InviteFriendsController() : getSystemResource = sl();
  String code = "";
  String shareCode = "";

  @override
  void onInit() {
    super.onInit();
    getUserCode();
  }

  Future<void> getUserCode() async {
    code = await sl<SharedPreferencesStorage>().getUserCode() ?? "";
    update();
    await getSystemResource.repository
        .getSystemResource(body: {"resourceGroup": "${AppConstants.resourceGroup}"}).then((value) => value.fold((failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            }, (systemResource) {
              shareCode = systemResource.value?.replaceAll("{0}", code) ?? code;
            }));
    update();
  }

  invite() {
    Share.share(shareCode.isEmpty ? code : shareCode);
  }
}
