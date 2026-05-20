import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/car_washer/car_wash/bookings/domain/entities/bookings_entity.dart';
import 'package:car_care/features/car_washer/car_wash/bookings/presentation/cubit/customer_bookings/customer_bookings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'booking_action_menu.dart';
import 'booking_details_content.dart';
import 'booking_status_chips.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
    this.showMenuByDefault = false,
  });

  final BookingsEntity booking;
  final bool showMenuByDefault;

  @override
  Widget build(BuildContext context) {
    final statusChips = <String>[booking.statusText];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.lightBorder),
          ),
          padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingStatusChips(statusChips: statusChips),
              SizedBox(height: 8.h),
              BookingDetailsContent(
                booking: booking,
                onShowDetails: () async {
                  final changed = await context.push(
                    Routes.bookingDetails,
                    extra: booking,
                  );
                  if (changed == true && context.mounted) {
                    context.read<CustomerBookingsCubit>().fetchBookings(
                      status: null,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        Positioned(
          left: 6.w,
          top: 8.h,
          child: showMenuByDefault
              ? const BookingActionMenu(showAsOpen: true)
              : const BookingActionMenu(),
        ),
      ],
    );
  }
}
