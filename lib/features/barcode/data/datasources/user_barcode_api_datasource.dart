import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';
import '../models/user_barcode_model.dart';

abstract class UserBarCodeApiDataSource {
  Future<UserBarcodeModel> getUserBarcode();
}

class UserBarCodeApiDataSourceImpl implements UserBarCodeApiDataSource {
  @override
  Future<UserBarcodeModel> getUserBarcode() async {
    UserBarcodeModel userBarcode = await ApiRequest<UserBarcodeModel>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getBarcodeUserData,
      body: {},
      authorized: true,
      fromJson: UserBarcodeModel.fromMap,
    );
    return userBarcode;
  }
}
