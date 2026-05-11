import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/app_headline.dart';
import 'package:car_care/core/widgets/const.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/car_washer/bookings/domain/entities/bookings_entity.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/booking_details_page/action_buttons.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/booking_details_page/details_card.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key, required this.booking});
  final BookingsEntity? booking;

  @override
  Widget build(BuildContext context) {
    final serviceLines = [
      '${context.l10n.bookingDetailsWasherNameLabel}:  ${booking!.vehicle.ownerName ?? '---'}',
      '${context.l10n.bookingsServiceLabel}:  ${booking!.serviceType}',
      '${context.l10n.bookingsPriceLabel}:  \$${booking!.price}',
      '${context.l10n.status}:  ${booking!.statusText}',
    ];

    final appointmentLines = [
      '${context.l10n.bookingsDateTimeLabel}: ${booking!.scheduledAt}',
      '${context.l10n.bookingDetailsVehicleLabel}: ${booking!.vehicle.brand} ${booking!.vehicle.model}',
      '${context.l10n.plate}: ${booking!.vehicle.plateNumber}',
    ];

    final userNotesLines = ['${context.l10n.notes}: ${booking!.notes}'];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: context.l10n.bookingDetailsPageTitle,
          showBackButton: true,
          onBackTapped: () => context.pop(),
        ),
        body: ImageBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/Carfinance-amico.png',
                      height: 150.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  AppText.sectionTitle(
                    context.l10n.bookingDetailsServiceSectionTitle,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(height: 6.h),
                  DetailsCard(lines: serviceLines),
                  SizedBox(height: 12.h),
                  AppText.sectionTitle(
                    context.l10n.bookingDetailsAppointmentSectionTitle,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(height: 6.h),
                  DetailsCard(lines: appointmentLines),
                  // SizedBox(height: 12.h),
                  // AppText.sectionTitle(
                  //   context.l10n.bookingDetailsUserNotesSectionTitle,
                  //   fontSize: 19.sp,
                  //   fontWeight: FontWeight.w800,
                  // ),
                  // SizedBox(height: 6.h),
                  // DetailsCard(lines: userNotesLines),
                  SizedBox(height: 25.h),
                  const ActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
