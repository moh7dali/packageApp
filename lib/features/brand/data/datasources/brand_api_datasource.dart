import 'package:my_custom_widget/features/brand/data/models/brand_details_list_model.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entities/brand_details.dart';
import '../../domain/entities/brands_list.dart';
import '../models/brand_details_model.dart';

abstract class BrandApiDataSource {
  Future<BrandDetailsList> getAllBrands({Map<String, dynamic>? queryParameters});

  Future<BrandDetailsList> getBusinessUnitBrands({Map<String, dynamic>? queryParameters});

  Future<BrandDetails?> getBrandDetails({Map<String, dynamic>? queryParameters});
}

class BrandApiDataSourceImpl implements BrandApiDataSource {
  @override
  Future<BrandDetailsList> getAllBrands({Map<String, dynamic>? queryParameters}) async {
    BrandDetailsList brandDetailsList = await ApiRequest<BrandDetailsList>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getAllBrands,
      body: {},
      queryParameters: queryParameters,
      fromJson: BrandDetailsListModel.fromJson,
    );
    return brandDetailsList;
  }

  @override
  Future<BrandDetails?> getBrandDetails({Map<String, dynamic>? queryParameters}) async {
    BrandDetails? brandDetails = await ApiRequest<BrandDetails?>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getBrandDetails,
      queryParameters: queryParameters,
      body: {},
      fromJson: BrandDetailsModel.fromJson,
    );
    return brandDetails;
  }

  @override
  Future<BrandDetailsList> getBusinessUnitBrands({Map<String, dynamic>? queryParameters}) async {
    BrandDetailsList brandDetailsList = await ApiRequest<BrandDetailsList>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getBusinessUnitBrands,
      body: {},
      queryParameters: queryParameters,
      fromJson: BrandDetailsListModel.fromJson,
    );
    return brandDetailsList;
  }
}
