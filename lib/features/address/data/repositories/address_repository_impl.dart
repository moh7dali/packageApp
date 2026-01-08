import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/address/data/datasources/address_api_datasource.dart';
import 'package:my_custom_widget/features/address/domain/entity/customer_addresses.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressApiDataSource remoteDataSource;

  AddressRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, dynamic>> addNewCustomerAddress({required Map<String, dynamic> body}) async {
    try {
      final addNewAddress = await remoteDataSource.addNewCustomerAddress(body: body);
      return Right(addNewAddress);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, CustomerAddresses>> getCustomerAddresses() async {
    try {
      final getAddress = await remoteDataSource.getCustomerAddresses();
      return Right(getAddress);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, dynamic>> deleteCustomerAddress({required Map<String, dynamic> body}) async {
    try {
      final deleteAddress = await remoteDataSource.deleteCustomerAddress(body: body);
      return Right(deleteAddress);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }
}
