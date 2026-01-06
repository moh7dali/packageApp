import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetBrandCategories implements UseCase<CategoryList?, BodyParams> {
  final CategoryRepository repository;

  GetBrandCategories(this.repository);

  @override
  Future<Either<AppFailure, CategoryList?>> call(BodyParams params) async {
    return await repository.getBrandCategories(body: params.body);
  }
}
