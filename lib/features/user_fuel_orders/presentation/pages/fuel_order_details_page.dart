import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/user_fuel_orders/presentation/widgets/fuel_order_details/fuel_order_details_body.dart';
import 'package:car_care/features/user_fuel_orders/presentation/widgets/fuel_order_details/fuel_order_details_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FuelOrderDetailsPage extends StatelessWidget {
  const FuelOrderDetailsPage({super.key, this.order});

  final FuelOrderDetailsUiModel? order;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final details = order ?? FuelOrderDetailsUiModel.preview;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: l10n.fuelOrderDetailsTitle,
          showBackButton: true,
          backgroundColor: AppColors.carWashTeal,
          onBackTapped: () => context.pop(),
        ),
        body: ImageBackground(
          child: FuelOrderDetailsBody(order: details),
        ),
      ),
    );
  }
}
