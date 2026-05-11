import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/car_washer/bookings/domain/entities/bookings_entity.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_details/washer_bookings_details_section.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherBookingsDetailsBody extends StatelessWidget {
  const WasherBookingsDetailsBody({
    super.key,
    required this.booking,
  });

  final BookingsEntity booking;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final ownerName = booking.vehicle.ownerName ?? '---';
    final vehicleName = '${booking.vehicle.brand} ${booking.vehicle.model}'.trim();
    final plate = booking.vehicle.plateNumber;
    final priceText = booking.price ?? '0';

    final serviceLines = <String>[
      '${l10n.washerBookingCustomerNameLabel} $ownerName',
      '${l10n.bookingsServiceLabel}: ${booking.serviceType}',
      '${l10n.bookingsPriceLabel}: \$$priceText',
      '${l10n.bookingsDateTimeLabel}: ${booking.scheduledAt}',
      '${l10n.bookingDetailsVehicleLabel}: $vehicleName',
      '${l10n.plate}: $plate',
    ];

    final userNotesLines = <String>[
      booking.notes.isNotEmpty ? booking.notes : '---',
    ];

    return Column(
      children: [
        Expanded(
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 150.w,
                      height: 150.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.9),
                          width: 3,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/images/Carfinance-amico.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  WasherBookingsDetailsSection(
                    title: l10n.bookingDetailsServiceSectionTitle,
                    lines: serviceLines,
                  ),
                  SizedBox(height: 12.h),
                  WasherBookingsDetailsSection(
                    title: l10n.bookingDetailsUserNotesSectionTitle,
                    lines: userNotesLines,
                    textAlign: TextAlign.center,
                    contentFontWeight: FontWeight.w800,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}