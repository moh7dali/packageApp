import 'package:my_custom_widget/features/menu/domain/usecases/delete_account.dart';
import 'package:my_custom_widget/features/menu/domain/usecases/logout.dart';
import 'package:my_custom_widget/my_custom_widget.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/helper/shared_preferences_storage.dart';

class MenuTabController extends GetxController {
  final DeleteAccount deleteAccount;
  final Logout logout;

  bool changeTheme = true;

  MenuTabController()
      : deleteAccount = sl(),
        logout = sl();

  @override
  void onInit() {
    changeTheme = themeController.isDark.value;
    update();
    super.onInit();
  }

  logoutOrDeleteAccount({bool delete = false}) async {
    if (delete) {
      await deleteAccount.repository.deleteAccount().then((value) => value.fold((failure) {
            SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
          }, (r) async {
            await sl<SharedPreferencesStorage>().deleteAllData();
            Get.deleteAll();
            Get.offAllNamed(RouteConstant.authPage);
          }));
    } else {
      await logout.repository.logOut().then((value) => value.fold((failure) {
            SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
          }, (r) async {
            await sl<SharedPreferencesStorage>().deleteAllData();
            Get.deleteAll();
            Get.offAllNamed(RouteConstant.authPage);
          }));
    }
  }
}
