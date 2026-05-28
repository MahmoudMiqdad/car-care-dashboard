import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/app_headline.dart';
import 'package:car_care/features/fuel_provider/provider_statistics/presentation/widgets/provider_statistics/provider_statistics_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderStatisticsOrdersCard extends StatelessWidget {
  const ProviderStatisticsOrdersCard({super.key, required this.statistics});

  final ProviderStatisticsUiModel statistics;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText.sectionTitle(
          l10n.providerStatisticsTotalOrdersTitle,
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.86),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.lightBorder),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _SummaryColumn(
                    items: [
                      _SummaryItem(
                        l10n.showRatingAllReserved,
                        statistics.totalOrders,
                      ),
                      _SummaryItem(
                        l10n.pending,
                        statistics.pendingOrders,
                      ),
                      _SummaryItem(
                        l10n.bookingStatusAccepted,
                        statistics.acceptedOrders,
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  width: 24.w,
                  thickness: 1,
                  color: AppColors.lightTextSecondary,
                ),
                Expanded(
                  child: _SummaryColumn(
                    items: [
                      _SummaryItem(
                        l10n.bookingStatusProgress,
                        statistics.inProgressOrders,
                      ),
                      _SummaryItem(
                        l10n.completed,
                        statistics.completedOrders,
                      ),
                      _SummaryItem(
                        l10n.cancelled,
                        statistics.cancelledOrders,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryColumn extends StatelessWidget {
  const _SummaryColumn({required this.items});

  final List<_SummaryItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: RichText(
                textDirection: TextDirection.ltr,
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(text: '${item.label} : '),
                    TextSpan(
                      text: '${item.value}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SummaryItem {
  const _SummaryItem(this.label, this.value);

  final String label;
  final int value;
}
