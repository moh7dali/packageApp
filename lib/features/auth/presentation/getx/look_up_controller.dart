import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/app_log.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../domain/entities/look_up.dart';
import '../../domain/usecases/get_lookups.dart';

class LookUpController extends GetxController {
  List<LookUp>? allLookUps;
  final GetLookups getLookups;
  bool isLookUpLoading = true;
  bool isProfile;

  LookUpController({this.isProfile = false}) : getLookups = sl();

  @override
  void onInit() {
    appLog("Inside the LookUpController");
    if (!isProfile) {
      getLookUpList();
    } else {
      isLookUpLoading = false;
      update();
    }
    super.onInit();
  }

  getLookUpList() async {
    isLookUpLoading = true;
    update();
    await getLookups.repository.getLookUp(body: {
      "lookupCatId": "${AppConstants.visitorTypeLookupId}",
    }).then((value) => value.fold(
          (failure) {
            SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            isLookUpLoading = false;
            update();
          },
          (lookUps) {
            allLookUps = lookUps;
            isLookUpLoading = false;
            update();
          },
        ));
    appLog("the list of Look Up is : $allLookUps");
    update;
  }
}
