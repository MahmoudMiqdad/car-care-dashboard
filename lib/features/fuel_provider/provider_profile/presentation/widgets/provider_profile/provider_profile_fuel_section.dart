import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/widgets/provider_profile/provider_profile_cards.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/widgets/provider_profile/provider_profile_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderProfileFuelPricesSection extends StatelessWidget {
  const ProviderProfileFuelPricesSection({super.key, required this.profile});

  final ProviderProfileUiModel profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProviderProfileSectionTitle(
          title: l10n.providerProfileServicesAndPricesTitle,
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            for (var i = 0; i < profile.fuelPrices.length; i++) ...[
              if (i > 0) SizedBox(width: 8.w),
              Expanded(
                child: _FuelPriceCard(fuelPrice: profile.fuelPrices[i]),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _FuelPriceCard extends StatelessWidget {
  const _FuelPriceCard({required this.fuelPrice});

  final ProviderProfileFuelPriceUiModel fuelPrice;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final borderColor = AppColors.carWashTeal;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              fuelPrice.fuelType,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w800,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Divider(
              height: 1,
              thickness: 1,
              color: borderColor.withValues(alpha: 0.35),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.providerProfilePriceLine(fuelPrice.price),
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
