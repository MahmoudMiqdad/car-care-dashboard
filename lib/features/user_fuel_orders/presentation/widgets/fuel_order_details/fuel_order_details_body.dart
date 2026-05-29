import 'package:car_care/core/constants/app_constants.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/buttons/app_button_widget.dart';
import 'package:car_care/core/widgets/cancel_reason_dialog.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_status_banner.dart';
import 'package:car_care/features/user_fuel_orders/presentation/widgets/fuel_order_details/fuel_order_details_location_card.dart';
import 'package:car_care/features/user_fuel_orders/presentation/widgets/fuel_order_details/fuel_order_details_order_card.dart';
import 'package:car_care/features/user_fuel_orders/presentation/widgets/fuel_order_details/fuel_order_details_provider_card.dart';
import 'package:car_care/features/user_fuel_orders/presentation/widgets/fuel_order_details/fuel_order_details_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FuelOrderDetailsBody extends StatelessWidget {
  const FuelOrderDetailsBody({super.key, required this.order});

  final FuelOrderDetailsUiModel order;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          AppConstants.pageHorizontal,
          16.h,
          AppConstants.pageHorizontal,
          24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SosDetailsStatusBanner(label: l10n.sosDetailsRequestAccepted),
            SizedBox(height: 14.h),
            FuelOrderDetailsOrderCard(order: order),
            SizedBox(height: 14.h),
            FuelOrderDetailsProviderCard(order: order),
            SizedBox(height: 14.h),
            FuelOrderDetailsLocationCard(order: order),
            SizedBox(height: 22.h),
            AppButton(
              onPressed: () async {
                await showCancelReasonDialog(
                  context,
                  title: l10n.fuelCancelReasonDialogTitle,
                );
              },
              text: l10n.sosDetailsCancelRequest,
              backgroundColor: AppColors.reservationConfirmOrange,
              textColor: AppColors.white,
              borderRadius: 14.r,
              height: 52.h,
            ),
          ],
        ),
      ),
    );
  }
}
