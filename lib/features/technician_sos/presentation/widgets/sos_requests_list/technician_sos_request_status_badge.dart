import 'package:car_care/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TechnicianSosRequestStatusBadgeStyle { outlineOnWhite, softSuccess }

class _SosRequestStatusBadgeLayout {
  _SosRequestStatusBadgeLayout._();

  static double get width => 108.w;
  static double get height => 36.h;
}

class SosTechnicianRequestStatusBadge extends StatelessWidget {
  const SosTechnicianRequestStatusBadge({
    super.key,
    required this.label,
    required this.style,
  });

  final String label;
  final TechnicianSosRequestStatusBadgeStyle style;

  @override
  Widget build(BuildContext context) {
    final bool outline = style == TechnicianSosRequestStatusBadgeStyle.outlineOnWhite;
    return Container(
      width: _SosRequestStatusBadgeLayout.width,
      height: _SosRequestStatusBadgeLayout.height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: outline
            ? AppColors.white
            : AppColors.serviceTierSelectedBackground,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: outline ? AppColors.carWashTeal : AppColors.success,
          width: 1,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
