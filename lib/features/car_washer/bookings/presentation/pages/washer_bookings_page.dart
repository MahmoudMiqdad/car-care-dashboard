import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/const.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_card.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_filter.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:car_care/features/car_washer/bookings/presentation/cubit/washer_bookings/bookings_cubit.dart';
import 'package:car_care/features/car_washer/bookings/presentation/cubit/bookings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:car_care/core/service_locator/service_locator.dart';

class WasherBookingsPage extends StatelessWidget {
  const WasherBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BookingsCubit>()..fetchBookings(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(
            title: context.l10n.bookingsPageTitle,
            showBackButton: true,
            onBackTapped: () => context.pop(),
          ),
          backgroundColor: AppColors.lightScaffold,
          body: ImageBackground(
            child: SafeArea(
              child: BlocBuilder<BookingsCubit, BookingsState>(
                builder: (context, state) {
                  if (state is BookingsLoading) {
                    return const Center(child: AppLoadingWidget());
                  } else if (state is BookingsError) {
                    return Center(child: Text(state.message));
                  } else if (state is BookingsLoaded) {
                    final realBookings = state.items;

                    return ListView.separated(
                      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 20.h),
                      itemCount: realBookings.length + 1,
                      separatorBuilder: (_, index) => SizedBox(height: 14.h),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const WasherBookingFilter();
                        }
                        return WasherBookingCard(
                          booking: realBookings[index - 1],
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
