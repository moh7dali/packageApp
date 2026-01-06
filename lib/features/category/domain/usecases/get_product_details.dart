import 'package:my_custom_widget/features/category/domain/entities/product_details.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/category_repository.dart';

class GetProductDetails implements UseCase<ProductDetails?, BodyParams> {
  final CategoryRepository repository;

  GetProductDetails(this.repository);

  @override
  Future<Either<AppFailure, ProductDetails?>> call(BodyParams params) async {
    return await repository.getProductDetails(queryParameters: params.body);
  }
}
