import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_info_row.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_section_card.dart';
import 'package:car_care/features/user_fuel_orders/presentation/widgets/fuel_order_details/fuel_order_details_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FuelOrderDetailsOrderCard extends StatelessWidget {
  const FuelOrderDetailsOrderCard({super.key, required this.order});

  final FuelOrderDetailsUiModel order;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SosDetailsSectionCard(
      title: l10n.sosDetailsRequestData,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  order.vehicleTitle,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                SosDetailsInfoRow(
                  iconAsset: AppAssets.plateNumberIcon,
                  label: l10n.sosDetailsPlateNumberLabel,
                  value: order.plateNumber,
                ),
                SosDetailsInfoRow(
                  iconAsset: AppAssets.serviceFuel,
                  label: l10n.fuel,
                  value: order.fuel,
                ),
                SosDetailsInfoRow(
                  iconAsset: AppAssets.fuelOrderMoneyIcon,
                  label: l10n.price,
                  value: order.price,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          CircleAvatar(
            radius: 44.r,
            backgroundColor: AppColors.lightSurface,
            backgroundImage: order.vehicleImageAsset != null
                ? AssetImage(order.vehicleImageAsset!)
                : const AssetImage(AppAssets.technicianJobVehicleIcon),
          ),
        ],
      ),
    );
  }
}
