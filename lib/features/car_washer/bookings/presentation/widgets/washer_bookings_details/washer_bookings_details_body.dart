import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_details/washer_bookings_details_section.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherBookingsDetailsBody extends StatelessWidget {
  const WasherBookingsDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final serviceLines = [
      '${l10n.washerBookingCustomerNameLabel} محمود المقداد',
      '${l10n.bookingsServiceLabel}: Vip',
      '${l10n.bookingsPriceLabel}: \$20',
      '${l10n.bookingsDateTimeLabel}: 4 / 15 ${l10n.bookingsAtLabel} 4:00',
      '${l10n.bookingDetailsVehicleLabel}: هوندا سيتي',
      '${l10n.plate}: 456789',
    ];

    final userNotesLines = [
      'السيارة من نوع نيسان التيما وهي من فئة السيارات السيدان الرياضية باللون الأحمر',
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
