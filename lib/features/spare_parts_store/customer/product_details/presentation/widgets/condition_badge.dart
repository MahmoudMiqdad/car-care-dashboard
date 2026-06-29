// شارة تعرض حالة المنتج: جديد أو مستعمل
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConditionBadge extends StatelessWidget {
  const ConditionBadge({super.key, required this.isNew});

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final color = isNew ? AppColors.success : AppColors.warning;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        isNew ? 'جديد' : 'مستعمل',
        style: AppTypography.labelSmall.copyWith(color: color),
      ),
    );
  }
}
