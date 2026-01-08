import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/category/domain/entities/category.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/category_repository.dart';

class GetSubCategories implements UseCase<CategoryList?, BodyParams> {
  final CategoryRepository repository;

  GetSubCategories(this.repository);

  @override
  Future<Either<AppFailure, CategoryList?>> call(BodyParams params) async {
    return await repository.getCategorySubCategories(queryParameters: params.body);
  }
}
