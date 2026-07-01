// كرت يعرض موقع التوصيل المختار أو يدعو لاختياره
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class CheckoutLocationCard extends StatelessWidget {
  const CheckoutLocationCard({
    super.key,
    required this.selectedLocation,
    required this.onPickLocation,
  });

  final LatLng? selectedLocation;
  final VoidCallback onPickLocation;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedLocation != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withOpacity(0.04)
            : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.accent,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'موقع التوصيل',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.lightTextPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: child,
                      ),
                      child: !isSelected
                          ? Text(
                              'اختر الموقع من الخريطة',
                              key: const ValueKey('hint'),
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.lightTextSecondary,
                              ),
                            )
                          : const SizedBox.shrink(key: ValueKey('empty')),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: isSelected
                    ? Container(
                        key: const ValueKey('badge'),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: AppColors.success,
                              size: 12.sp,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              'تم التحديد',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(key: ValueKey('no-badge')),
              ),
            ],
          ),
          // الإحداثيات تظهر بانتقال ناعم عند اختيار الموقع
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 280),
              opacity: isSelected ? 1 : 0,
              child: isSelected
                  ? Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${selectedLocation!.latitude.toStringAsFixed(5)}, '
                          '${selectedLocation!.longitude.toStringAsFixed(5)}',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.lightTextSecondary,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: onPickLocation,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 16.sp, color: AppColors.primary),
                  SizedBox(width: 6.w),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      isSelected ? 'تغيير الموقع' : 'اختيار الموقع من الخريطة',
                      key: ValueKey(isSelected),
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
