import 'package:my_custom_widget/core/error/failures.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/create_order.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_checkout_data.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_details.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_history.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/payment_status.dart';
import 'package:my_custom_widget/features/ordering/domain/repositories/ordering_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api/api_response.dart';
import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../datasource/ordering_api_datasource.dart';

class OrderingRepositoryImpl implements OrderingRepositories {
  final OrderingApiDataSource remoteDataSource;

  OrderingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, OrderCheckoutData>> getOrderCheckoutData({required Map<String, dynamic> body}) async {
    try {
      final remoteOrdering = await remoteDataSource.getOrderCheckoutData(body: body);
      return Right(remoteOrdering);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, ApiResponse<CreateOrder>>> createOrder({required Map<String, dynamic> body}) async {
    try {
      final createOrdering = await remoteDataSource.createOrderApi(body: body);
      return Right(createOrdering);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, OrderHistoryList>> getCustomerOrders({required Map<String, dynamic> body}) async {
    try {
      final orderList = await remoteDataSource.getCustomerOrders(body: body);
      return Right(orderList);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, OrderDetails>> getOrderDetails({required Map<String, dynamic> body}) async {
    try {
      final orderDetails = await remoteDataSource.getOrderDetails(body: body);
      return Right(orderDetails);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, OrderingStatus>> checkOrderingStatus({required Map<String, dynamic> body}) async {
    try {
      final orderStatus = await remoteDataSource.checkOrderingStatus(body: body);
      return Right(orderStatus);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, PaymentStatus>> checkOrderPaymentStatus({required Map<String, dynamic> body}) async {
    try {
      final paymentStatus = await remoteDataSource.checkOrderPaymentStatus(body: body);
      return Right(paymentStatus);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, dynamic>> cancelOrderPayment({required Map<String, dynamic> body}) async {
    try {
      final cancel = await remoteDataSource.cancelOrderPayment(body: body);
      return Right(cancel);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, dynamic>> logPaymentFailure({required Map<String, dynamic> body}) async {
    try {
      final fail = await remoteDataSource.logPaymentFailure(body: body);
      return Right(fail);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }
}
