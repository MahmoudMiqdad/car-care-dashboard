// شريط سفلي ثابت يعرض إجمالي سلة المشتريات
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartTotalBar extends StatelessWidget {
  const CartTotalBar({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الإجمالي',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.accent,
              ),
            ),
            Text(
              '${total.toStringAsFixed(0)} ل.س',
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
