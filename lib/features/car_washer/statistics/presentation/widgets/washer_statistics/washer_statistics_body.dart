import 'package:car_care/features/car_washer/statistics/presentation/widgets/washer_statistics/washer_statistics_comments_section.dart';
import 'package:car_care/features/car_washer/statistics/presentation/widgets/washer_statistics/washer_statistics_ratings_section.dart';
import 'package:car_care/features/car_washer/statistics/presentation/widgets/washer_statistics/washer_statistics_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherStatisticsBody extends StatelessWidget {
  const WasherStatisticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: const Column(
        children: [
          WasherStatisticsSummaryCard(),
          SizedBox(height: 10),
          WasherStatisticsRatingsSection(),
          SizedBox(height: 10),
          WasherStatisticsCommentsSection(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
