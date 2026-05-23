import 'package:car_care/core/constants/app_constants.dart';
import 'package:car_care/features/fuel_provider/provider_available_orders/presentation/widgets/provider_available_orders/provider_available_orders_cards.dart';
import 'package:car_care/features/fuel_provider/provider_available_orders/presentation/widgets/provider_available_orders/provider_available_orders_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderAvailableOrdersBody extends StatelessWidget {
  const ProviderAvailableOrdersBody({
    super.key,
    required this.orders,
    this.onViewDetails,
  });

  final List<ProviderAvailableOrderUiModel> orders;
  final void Function(ProviderAvailableOrderUiModel order)? onViewDetails;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(
          AppConstants.pageHorizontal,
          30.h,
          AppConstants.pageHorizontal,
          16.h,
        ),
        itemCount: orders.length,
        separatorBuilder: (context, _) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final order = orders[index];
          return ProviderAvailableOrderCard(
            order: order,
            onViewDetails: onViewDetails == null
                ? null
                : () => onViewDetails!(order),
          );
        },
      ),
    );
  }
}
