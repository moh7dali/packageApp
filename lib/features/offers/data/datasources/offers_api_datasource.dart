import 'package:my_custom_widget/features/offers/data/models/offers_list_model.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entity/offers_list.dart';

abstract class OffersApiDataSource {
  Future<OffersList> getOffers({required Map<String, dynamic> body});
}

class OffersApiDataSourceImpl implements OffersApiDataSource {
  @override
  Future<OffersList> getOffers({required Map<String, dynamic> body}) async {
    OffersList brandDetailsList = await ApiRequest<OffersList>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getOffers,
      body: body,
      fromJson: OffersListModel.fromJson,
    );
    return brandDetailsList;
  }
}
