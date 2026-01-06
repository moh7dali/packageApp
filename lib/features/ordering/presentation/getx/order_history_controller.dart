import 'package:get/get.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_history.dart';
import 'package:my_custom_widget/features/ordering/domain/usecases/get_customer_order.dart';

import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';

class OrderHistoryController extends GetxController {
  final GetCustomerOrders getCustomerOrder;
  List<OrderHistory> orders = [];

  OrderHistoryController() : getCustomerOrder = sl();

  Future<PaginationListModel> getAllCustomerOrders({int page = 1}) async {
    orders = [];
    int totalNumberOfResult = 0;
    await getCustomerOrder.repository.getCustomerOrders(body: {"pageNumber": '$page', "sortDescending": true}).then(
      (value) => value.fold(
        (failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        },
        (ordersList) {
          List<OrderHistory> list = ordersList.list ?? [];
          orders = list;
          totalNumberOfResult = ordersList.totalNumberOfResult ?? 0;
        },
      ),
    );
    return PaginationListModel(listOfObjects: orders, totalNumberOfResult: totalNumberOfResult);
  }
}
