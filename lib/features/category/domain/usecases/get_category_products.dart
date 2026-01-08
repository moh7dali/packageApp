import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/category/domain/entities/product.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/category_repository.dart';

class GetCategoryProducts implements UseCase<ProductList?, BodyParams> {
  final CategoryRepository repository;

  GetCategoryProducts(this.repository);

  @override
  Future<Either<AppFailure, ProductList?>> call(BodyParams params) async {
    return await repository.getCategoryProducts(body: params.body);
  }
}
