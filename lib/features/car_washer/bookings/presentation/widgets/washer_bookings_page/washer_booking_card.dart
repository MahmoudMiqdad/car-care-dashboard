import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_info_column.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_model.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_quick_actions_column.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_status_chips_row.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_view_details_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherBookingCard extends StatelessWidget {
  const WasherBookingCard({super.key, required this.data, this.onViewDetails});

  final WasherBookingData data;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.lightBorder),
      ),
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
      child: Column(
        children: [
          WasherBookingStatusChipsRow(labels: data.statuses),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: WasherBookingInfoColumn(data: data)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Container(
                  width: 1,
                  height: 200.h,
                  color: AppColors.black.withValues(alpha: 0.35),
                ),
              ),
              const WasherBookingQuickActionsColumn(),

            ],
          ),
          SizedBox(height: 10.h),
          WasherBookingViewDetailsButton(onPressed: onViewDetails),
        ],
      ),
    );
  }
}
