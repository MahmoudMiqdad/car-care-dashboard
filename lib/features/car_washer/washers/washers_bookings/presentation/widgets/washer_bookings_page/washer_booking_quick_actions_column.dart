import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherBookingQuickActionsColumn extends StatelessWidget {
  const WasherBookingQuickActionsColumn({
    super.key,
    required this.showAcceptReject,
    required this.showStartComplete,
    required this.showCompleteOnly,
    required this.rejectMode,
    required this.rejectController,
    required this.onAccept,
    required this.onRejectTap,
    required this.onRejectSubmit,
    required this.onStartExecution,
    required this.onComplete,
  });

  final bool showAcceptReject;
  final bool showStartComplete;
  final bool showCompleteOnly;

  final bool rejectMode;
  final TextEditingController rejectController;

  final VoidCallback onAccept;
  final VoidCallback onRejectTap;
  final VoidCallback onRejectSubmit;

  final VoidCallback onStartExecution;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Reject reason UI
    if (showAcceptReject && rejectMode) {
      return SizedBox(
        width: 120.w,
        child: Column(
          children: [
            SizedBox(height: 40.h),
            TextField(
              controller: rejectController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'سبب الرفض',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
            ),
            SizedBox(height: 6.h),
            _ActionBtn(
              label: 'إرسال',
              onPressed: onRejectSubmit,
              filled: true,
            ),
          ],
        ),
      );
    }

    // pending => accept/reject
    if (showAcceptReject) {
      return Column(
        children: [
          SizedBox(height: 40.h),
          _ActionBtn(label: l10n.washerBookingAccept, onPressed: onAccept),
          _ActionBtn(label: l10n.washerBookingReject, onPressed: onRejectTap),
        ],
      );
    }

    // accepted => start/complete
    if (showStartComplete) {
      return Column(
        children: [
          SizedBox(height: 40.h),
          _ActionBtn(label: l10n.washerBookingStartExecution, onPressed: onStartExecution),
          _ActionBtn(label: l10n.washerBookingCompleted, onPressed: onComplete),
        ],
      );
    }

    // in_progress => complete only
    if (showCompleteOnly) {
      return Column(
        children: [
          SizedBox(height: 40.h),
          _ActionBtn(label: l10n.washerBookingCompleted, onPressed: onComplete),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.label,
    required this.onPressed,
    this.filled = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: SizedBox(
        width: 90.w,
        height: 28.h,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary, width: 1),
            padding: EdgeInsets.zero,
            backgroundColor: filled ? AppColors.primary : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: filled ? Colors.white : AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}