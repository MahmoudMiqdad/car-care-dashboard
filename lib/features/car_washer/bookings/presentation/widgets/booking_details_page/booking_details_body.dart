import 'package:car_care/features/car_washer/bookings/domain/entities/bookings_entity.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/booking_details_page/action_buttons.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/booking_details_page/booking_details_section.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsBody extends StatelessWidget {
  final BookingsEntity? booking;

  BookingDetailsBody({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final serviceDetails = <String>[
      '${l10n.bookingDetailsWasherNameLabel}:  المقداد',
      '${l10n.bookingsServiceLabel}:  Vip',
      '${l10n.bookingsPriceLabel}:  \$20',
      '${l10n.status}:  مقبول',
    ];

    final appointmentDetails = <String>[
      '${l10n.bookingsDateTimeLabel}: 4 / 15 ${l10n.bookingsAtLabel} 4:00',
      '${l10n.bookingDetailsOrderDateLabel}: 4/10',
      '${l10n.bookingDetailsVehicleLabel}: هوندا سيتي',
    ];

    return SafeArea(
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
            BookingDetailsSection(
              title: l10n.bookingDetailsServiceSectionTitle,
              lines: serviceDetails,
            ),
            SizedBox(height: 12.h),
            BookingDetailsSection(
              title: l10n.bookingDetailsAppointmentSectionTitle,
              lines: appointmentDetails,
            ),

            SizedBox(height: 25.h),
            ActionButtons(booking: booking!),
          ],
        ),
      ),
    );
  }
}
