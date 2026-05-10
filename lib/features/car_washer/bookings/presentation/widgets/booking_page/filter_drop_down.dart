import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../l10n.dart';
import '../../../../../../core/theme/app_colors.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({super.key, required this.onSelected});

  final void Function(String status) onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final Map<String, String> statuses = {
      'pending': l10n.bookingStatusPending,
      'accepted': l10n.bookingStatusAccepted,
      'in_progress': l10n.bookingStatusProgress,
      'completed': l10n.bookingStatusCompleted,
      'canceled': l10n.bookingStatusCanceled,
    };

    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) => statuses.entries
          .map((e) => PopupMenuItem<String>(
                value: e.key,
                child: Text(e.value),
              ))
          .toList(),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primary, width: 1.2),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          children: [
            Text(
              l10n.bookingsFilterByStatus,
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            const Spacer(),
            Icon(Icons.expand_more, size: 22.sp),
          ],
        ),
      ),
    );
  }
}