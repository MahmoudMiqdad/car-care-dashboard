import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/const.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_card.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_filter.dart';
import 'package:car_care/features/car_washer/bookings/presentation/widgets/washer_bookings_page/washer_booking_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WasherBookingsPage extends StatelessWidget {
  const WasherBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 20.h),
              itemCount: bookings.length + 1,
              separatorBuilder: (_, index) => SizedBox(height: 14.h),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const WasherBookingFilter();
                }
                return WasherBookingCard(data: bookings[index - 1]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

const List<WasherBookingData> bookings = [
  WasherBookingData(
    customerName: 'محمود',
    serviceName: 'Vip',
    dateTime: '4 / 15 الساعة 4:00',
    price: '\$20',
    vehicle: 'تويوتا',
    plateNumber: '876054',
    statuses: ['canceled', 'progress', 'accepted', 'pending'],
  ),
  WasherBookingData(
    customerName: 'خالد',
    serviceName: 'Vip',
    dateTime: '5 / 25 الساعة 3:00',
    price: '\$20',
    vehicle: 'هوندا',
    plateNumber: '927873',
    statuses: ['canceled', 'progress', 'accepted', 'pending'],
  ),
];
