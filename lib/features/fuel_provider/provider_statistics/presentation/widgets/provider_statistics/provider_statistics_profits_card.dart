import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/app_headline.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/widgets/provider_profile/provider_profile_cards.dart';
import 'package:car_care/features/fuel_provider/provider_statistics/presentation/widgets/provider_statistics/provider_statistics_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;

class ProviderStatisticsProfitsCard extends StatelessWidget {
  const ProviderStatisticsProfitsCard({super.key, required this.statistics});

  final ProviderStatisticsUiModel statistics;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final formattedProfits = NumberFormat('#,###').format(statistics.totalProfits);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText.sectionTitle(
          l10n.providerStatisticsTotalProfitsTitle,
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8.h),
        ProviderProfileTealBorderCard(
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Image.asset(
                AppAssets.fuelOrderMoneyIcon,
                width: 48.w,
                height: 48.w,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              Text(
                '\$ $formattedProfits',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
