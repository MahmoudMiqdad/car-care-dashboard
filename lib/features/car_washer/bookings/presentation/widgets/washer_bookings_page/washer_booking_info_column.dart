import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherBookingInfoColumn extends StatelessWidget {
  const WasherBookingInfoColumn({super.key, required this.data});

  final WasherBookingData data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WasherBookingInfoLine(
          label: l10n.washerBookingCustomerNameLabel,
          value: data.customerName,
          boldValue: true,
        ),
        WasherBookingInfoLine(
          label: l10n.washerBookingRequestedServiceLabel,
          value: data.serviceName,
          boldValue: true,
        ),
        WasherBookingInfoLine(
          label: l10n.washerBookingAppointmentLabel,
          value: data.dateTime,
          boldValue: true,
        ),
        WasherBookingInfoLine(
          label: '${l10n.bookingsPriceLabel} :',
          value: data.price,
          boldValue: true,
        ),
        WasherBookingInfoLine(
          label: '${l10n.bookingDetailsVehicleLabel} :',
          value: data.vehicle,
        ),
        WasherBookingInfoLine(
          label: '${l10n.plate} :',
          value: data.plateNumber,
        ),
      ],
    );
  }
}

class WasherBookingInfoLine extends StatelessWidget {
  const WasherBookingInfoLine({
    super.key,
    required this.label,
    required this.value,
    this.boldValue = false,
  });

  final String label;
  final String value;
  final bool boldValue;

  @override
  Widget build(BuildContext context) {
    return  RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w900,
            height: 1.5,
          ),
          children: [
            TextSpan(text: '$label '),
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight:  FontWeight.w600,
              ),
            ),
          ],
        ),
      
    );
  }
}
