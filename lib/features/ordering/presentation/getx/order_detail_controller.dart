import 'package:get/get.dart';
import 'package:my_custom_widget/features/ordering/domain/usecases/get_order_details.dart';

import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../domain/entity/order_details.dart';
import '../../domain/entity/order_history.dart';

class OrderDetailsController extends GetxController {
  final GetOrderDetails getOrderDetails;
  final OrderHistory? orderHistory;

  OrderDetailsController({required this.orderHistory}) : getOrderDetails = sl();

  OrderDetails? orderDetails;
  bool isLoading = true;

  Future<void> getOrderDetailsApi() async {
    Map<String, dynamic> body = {"orderId": "${orderHistory?.id}"};
    await getOrderDetails.repository.getOrderDetails(body: body).then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
              isLoading = false;
              update();
            },
            (orderInfo) {
              orderDetails = orderInfo;
              isLoading = false;
              update();
            },
          ),
        );
  }

  @override
  void onInit() {
    getOrderDetailsApi();
    super.onInit();
  }
}
