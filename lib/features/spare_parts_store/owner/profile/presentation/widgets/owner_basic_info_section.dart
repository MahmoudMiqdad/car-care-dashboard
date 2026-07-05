// قسم المعلومات الأساسية للمتجر.
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerBasicInfoSection extends StatelessWidget {
  const OwnerBasicInfoSection({
    super.key,
    required this.nameCtrl,
    required this.phoneCtrl,
    required this.cityCtrl,
    required this.isEnabled,
  });

  final TextEditingController nameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController cityCtrl;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabeledField(
          label: 'اسم المتجر',
          hint: 'أدخل اسم المتجر',
          icon: Icons.storefront_outlined,
          controller: nameCtrl,
          isEnabled: isEnabled,
        ),
        SizedBox(height: 12.h),
        _LabeledField(
          label: 'رقم الهاتف',
          hint: 'أدخل رقم الهاتف',
          icon: Icons.phone_outlined,
          controller: phoneCtrl,
          isEnabled: isEnabled,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 12.h),
        _LabeledField(
          label: 'المدينة',
          hint: 'أدخل اسم المدينة',
          icon: Icons.location_city_outlined,
          controller: cityCtrl,
          isEnabled: isEnabled,
        ),
      ],
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.isEnabled,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isEnabled;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          enabled: isEnabled,
          keyboardType: keyboardType,
          textDirection: TextDirection.rtl,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.lightTextPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.lightTextSecondary,
            ),
            prefixIcon: Icon(icon, color: AppColors.primary, size: 20.sp),
            filled: true,
            fillColor: isEnabled ? AppColors.white : AppColors.secondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.lightBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.lightBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.lightBorder.withOpacity(0.5),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }
}
