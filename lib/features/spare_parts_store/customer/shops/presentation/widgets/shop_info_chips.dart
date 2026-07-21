// قائمة Chips لعرض مجموعة قيم نصية (نوع النشاط، ماركات السيارات، فئات القطع) مع عنوان وهوية لونية خاصة بكل مجموعة
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopInfoChips extends StatelessWidget {
  const ShopInfoChips({
    super.key,
    required this.title,
    required this.values,
    this.titleIcon,
    this.chipColor = AppColors.primary,
  });

  final String title;
  final List<String> values;
  final IconData? titleIcon;
  final Color chipColor;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (titleIcon != null) ...[
              Icon(titleIcon, size: 17.sp, color: AppColors.primary),
              SizedBox(width: 6.w),
            ],
            Text(
              title,
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: values
              .map(
                (value) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: chipColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: chipColor.withOpacity(0.35)),
                  ),
                  child: Text(
                    value,
                    style: AppTypography.labelSmall.copyWith(
                      color: chipColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
