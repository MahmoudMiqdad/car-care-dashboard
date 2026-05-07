import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherBookingQuickActionsColumn extends StatelessWidget {
  const WasherBookingQuickActionsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        SizedBox(height: 40,),
        WasherBookingQuickActionButton(label: l10n.washerBookingAccept),
        WasherBookingQuickActionButton(label: l10n.washerBookingReject),
        WasherBookingQuickActionButton(label: l10n.washerBookingStartExecution),
        WasherBookingQuickActionButton(label: l10n.washerBookingCompleted),
      ],
    );
  }
}

class WasherBookingQuickActionButton extends StatelessWidget {
  const WasherBookingQuickActionButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: SizedBox(
        width: 72.w,
        height: 24.h,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary, width: 1),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          onPressed: () {},
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
