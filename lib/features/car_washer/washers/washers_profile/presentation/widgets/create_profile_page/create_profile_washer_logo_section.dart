import 'dart:io';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:car_care/core/widgets/dashed_border_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateProfileWasherLogoSection extends StatelessWidget {
  const CreateProfileWasherLogoSection({
    super.key,
    this.logoPath,
    this.onTap,
    this.uploadLabel = 'رفع الشعار',
  });

  final String? logoPath;
  final VoidCallback? onTap;
  final String uploadLabel;

  @override
  Widget build(BuildContext context) {
    final hasLogo = logoPath != null && logoPath!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            uploadLabel,
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w800,
              fontSize: 15.sp,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.r),
            child: DashedBorderBox(
              color: hasLogo ? AppColors.carWashTeal : AppColors.carWashTeal.withValues(alpha: 0.55),
              borderRadius: 12.r,
              child: Container(
                height: 110.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: hasLogo
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.file(
                          File(logoPath!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 36.sp,
                            color: AppColors.carWashTeal,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            uploadLabel,
                            style: AppTypography.bodyMedium.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
