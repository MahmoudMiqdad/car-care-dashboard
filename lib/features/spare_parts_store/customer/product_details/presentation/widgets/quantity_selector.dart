// عنصر للتحكم بكمية المنتج المطلوبة عبر زيادة/تقليل
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.maxQuantity,
    required this.onChanged,
  });

  final int quantity;
  final int maxQuantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        border: Border.all(color: AppColors.lightBorder),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            icon: Icons.remove,
            onTap: quantity > 1 ? () => onChanged(quantity - 1) : null,
          ),
          Container(width: 1, height: 26.h, color: AppColors.lightBorder),
          SizedBox(
            width: 40.w,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.lightTextPrimary,
              ),
            ),
          ),
          Container(width: 1, height: 26.h, color: AppColors.lightBorder),
          _StepperButton(
            icon: Icons.add,
            onTap: quantity < maxQuantity ? () => onChanged(quantity + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Icon(
          icon,
          size: 18.sp,
          color: onTap == null ? AppColors.lightBorder : AppColors.primary,
        ),
      ),
    );
  }
}
