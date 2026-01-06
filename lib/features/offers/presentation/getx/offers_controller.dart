import 'package:get/get.dart';
import 'package:my_custom_widget/features/offers/domain/usecase/get_offers.dart';

import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../domain/entity/offer.dart';

class OffersController extends GetxController {
  final GetAllOffers getAllOffers;

  OffersController() : getAllOffers = sl();

  List<Offer> offers = [];

  Future<PaginationListModel> getOffers({int page = 1}) async {
    offers = [];
    int totalNumberOfResult = 0;
    await getAllOffers.repository.getOffers(body: {"pageNumber": "$page"}).then((value) => value.fold((failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        }, (offersList) {
          List<Offer> offerForSize = offersList.offers ?? [];
          offers = offerForSize;
          totalNumberOfResult = offersList.totalNumberofResult ?? 0;
          update();
        }));
    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: offers);
  }
}
