import 'package:car_care/features/fuel_provider/provider_statistics/presentation/widgets/provider_statistics/provider_statistics_orders_card.dart';
import 'package:car_care/features/fuel_provider/provider_statistics/presentation/widgets/provider_statistics/provider_statistics_profits_card.dart';
import 'package:car_care/features/fuel_provider/provider_statistics/presentation/widgets/provider_statistics/provider_statistics_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderStatisticsBody extends StatelessWidget {
  const ProviderStatisticsBody({super.key, required this.statistics});

  final ProviderStatisticsUiModel statistics;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProviderStatisticsOrdersCard(statistics: statistics),
            SizedBox(height: 18.h),
            ProviderStatisticsProfitsCard(statistics: statistics),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
