import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/order_method/presentation/pages/selected_order_method.dart';
import 'package:my_custom_widget/my_custom_widget.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:my_custom_widget/shared/model/cart_items.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_preferences_storage.dart';

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({super.key, this.isHome = false});

  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CartItems>(
      valueListenable: cartItems,
      builder: (_, value, __) {
        int numberOfItems = value.products.fold(0, (sum, item) => sum + item.quantity);
        if (isHome && numberOfItems == 0) {
          return const SizedBox.shrink();
        }
        return Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              child: GestureDetector(
                onTap: () {
                  SharedHelper().needLogin(() async {
                    if (await sl<SharedPreferencesStorage>().getIsBranchSelected()) {
                      SDKNav.toNamed(RouteConstant.cartPage);
                    } else {
                      SharedHelper().scaleDialog(
                        SelectedOrderMethod(
                          onFinish: () {
                            SDKNav.toNamed(RouteConstant.cartPage);
                          },
                        ),
                      );
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isHome ? AppTheme.accentColor : Colors.transparent,
                    boxShadow: isHome ? [BoxShadow(color: AppTheme.secondaryColor, blurRadius: 5)] : [],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: SvgPicture.asset(AssetsConsts.cart, height: Get.width * .1, color: isHome ? null : AppTheme.primaryColor),
                  ),
                ),
              ),
            ),
            if (numberOfItems > 0)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Text(
                      '$numberOfItems',
                      style: AppTheme.textStyle(color: AppTheme.accentColor, size: AppTheme.size16, isBold: true),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
