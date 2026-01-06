import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/category/domain/entities/filters.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/category_repository.dart';

class GetCategoryFilters implements UseCase<FiltersList?, BodyParams> {
  final CategoryRepository repository;

  GetCategoryFilters(this.repository);

  @override
  Future<Either<AppFailure, FiltersList?>> call(BodyParams params) async {
    return await repository.getCategoryFilters(queryParameters: params.body);
  }
}
