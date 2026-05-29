import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_section_card.dart';
import 'package:car_care/features/user_fuel_orders/presentation/widgets/fuel_order_details/fuel_order_details_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FuelOrderDetailsProviderCard extends StatelessWidget {
  const FuelOrderDetailsProviderCard({super.key, required this.order});

  final FuelOrderDetailsUiModel order;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SosDetailsSectionCard(
      title: l10n.fuelOrderDetailsProviderSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            order.providerName,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                Image.asset(
                  AppAssets.iconPhoneCall,
                  width: 20.w,
                  height: 20.w,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.phone_in_talk_rounded,
                    size: 15.sp,
                    color: AppColors.carWashTeal,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                textAlign: TextAlign.start,
                  order.providerPhone,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
