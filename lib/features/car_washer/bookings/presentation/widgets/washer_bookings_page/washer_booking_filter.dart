import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/car_washer/bookings/presentation/cubit/washer_bookings/bookings_cubit.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherBookingFilter extends StatelessWidget {
  const WasherBookingFilter({super.key});

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
      onSelected: (String status) {
        context.read<BookingsCubit>().fetchBookings(status: status);
      },
      itemBuilder: (BuildContext context) {
        return statuses.entries.map((entry) {
          return PopupMenuItem<String>(
            value: entry.key,
            child: Text(entry.value),
          );
        }).toList();
      },
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primary, width: 1.3),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          children: [
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.black,
            ),
            SizedBox(width: 8.w),
            Text(
              l10n.bookingsFilterByStatus,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
