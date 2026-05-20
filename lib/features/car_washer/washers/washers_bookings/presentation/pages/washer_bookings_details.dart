import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/car_washer/car_wash/bookings/domain/entities/bookings_entity.dart';
import 'package:car_care/features/car_washer/washers/washers_bookings/presentation/widgets/washer_bookings_details/washer_bookings_details_body.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WasherBookingsDetails extends StatelessWidget {
  const WasherBookingsDetails({super.key, required this.booking});
  final BookingsEntity booking;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: context.l10n.bookingDetailsPageTitle,
          showBackButton: true,
          onBackTapped: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(Routes.washerBookings);
            }
          },
        ),
        body: ImageBackground(
          child: WasherBookingsDetailsBody(booking: booking),
        ),
      ),
    );
  }
}
