import 'package:car_care/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherBookingStatusChipsRow extends StatelessWidget {
  const WasherBookingStatusChipsRow({super.key, required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: labels
          .map(
            (label) => Padding(
              padding: EdgeInsetsDirectional.only(end: 5.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: chipColor(label),
                  borderRadius: BorderRadius.circular(999.r),
                  border: Border.all(color: AppColors.primary, width: 0.8),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Color chipColor(String label) {
    if (label.toLowerCase().contains('accept')) return AppColors.serviceTierSelectedBackground;
    if (label.toLowerCase().contains('cancel')) return const Color(0xFFF8D7DA); // أحمر خفيف
    if (label.toLowerCase().contains('progress')) return const Color(0xFFBCE5F8); // أزرق خفيف
    return const Color(0xFFDCECF5); // اللون الافتراضي
  }
}
