import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:car_care/core/widgets/app_circle_avatar.dart';
import 'package:car_care/features/car_washer/profile_washer/domain/entities/washer_profile_entity.dart';
import 'package:car_care/features/car_washer/profile_washer/presentation/widgets/profile_page/profile_washer_star_rating_row.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileWasherHeader extends StatelessWidget {
  const ProfileWasherHeader({super.key, required this.profile});

  final WasherProfileEntity profile;

  static const double _avatarDiameter = 132;

  int _stars(num avg) => avg.round().clamp(0, 5);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        SizedBox(
          width: _avatarDiameter.r,
          height: _avatarDiameter.r,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              AppCircleAvatar(
                diameter: _avatarDiameter,
                networkImageUrl: profile.logoUrl ?? '',
                placeholderAssetPath: AppAssets.washersPatternBackground,
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          profile.shopName,
          textAlign: TextAlign.center,
          style: AppTypography.headlineSmall.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 27.sp,
          ),
        ),
        ProfileWasherStarRatingRow(filledCount: _stars(profile.averageRating)),
        SizedBox(height: 6.h),
        Text(
          l10n.profileWasherRatingsCountLine(profile.ratingsCount),
          textAlign: TextAlign.center,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}