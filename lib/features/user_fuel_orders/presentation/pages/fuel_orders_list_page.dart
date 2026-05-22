import 'package:car_care/core/constants/app_constants.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/user_fuel_orders/presentation/widgets/fuel_orders_list/fuel_order_card.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FuelOrdersListPage extends StatelessWidget {
  const FuelOrdersListPage({super.key});

  static const List<FuelOrderUiModel> _sampleOrders = [
    FuelOrderUiModel(
      governorate: 'دمشق',
      vehicle: 'كيا ريو 2009',
      fuel: 'OCT 98 / 50L',
      price: '\$99',
      dateTime: '12/12/2026 - 7:55 PM',
    ),
    FuelOrderUiModel(
      governorate: 'دمشق',
      vehicle: 'كيا ريو 2009',
      fuel: 'OCT 98 / 50L',
      price: '\$99',
      dateTime: '12/12/2026 - 7:55 PM',
    ),
    
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: l10n.fuelOrdersListTitle,
          showBackButton: true,
          backgroundColor: AppColors.carWashTeal,
          onBackTapped: () => context.pop(),
        ),
        body: ImageBackground(
          child: SafeArea(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(
                AppConstants.pageHorizontal,
                30.h,
                AppConstants.pageHorizontal,
                16.h,
              ),
              itemCount: _sampleOrders.length,
              separatorBuilder: (context, _) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                return FuelOrderCard(order: _sampleOrders[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
