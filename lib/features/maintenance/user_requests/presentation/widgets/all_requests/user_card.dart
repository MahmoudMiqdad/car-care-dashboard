import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/app_info_row.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/maintenance_request_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.job, this.onTap});

  final DataEntity job;
  final VoidCallback? onTap;

  static String _formatDate(DateTime d) =>
      '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final bool isWaiting = job.status == 'waiting';
    final bool isCompleted = job.status == 'completed';
    final bool isAccepted = job.status == 'quotation_accepted';

    final Color statusBg = isWaiting
        ? const Color(0xFFD1F0F7)
        : (isCompleted || isAccepted
            ? const Color(0xFFDFF5E0)
            : const Color(0xFFFFE5E7));

    final Color statusColor = isWaiting
        ? const Color(0xFF007A92)
        : (isCompleted || isAccepted
            ? const Color(0xFF2E7D32)
            : AppColors.error);

    final IconData statusIcon = isWaiting
        ? Icons.hourglass_empty_rounded
        : isAccepted
            ? Icons.task_alt_rounded
            : isCompleted
                ? Icons.task_alt_rounded
                : Icons.cancel_outlined;

    final double localLabelSize = 17.sp;
    final double localValueSize = 16.sp;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              textDirection: TextDirection.rtl,
              children: [
                // المحتوى
                Expanded(
                  child: Container(
                    color: AppColors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppInfoRow(
                          label: 'وصف',
                          value: job.description.toString(),
                          labelFontSize: localLabelSize,
                          valueFontSize: localValueSize,
                          leading: _rowAsset(AppAssets.technicianJobNotesIcon),
                        ),
                        AppInfoRow(
                          label: 'المركبة',
                          value:
                              '${job.vehicle?.brand ?? ''} ${job.vehicle?.model ?? ''}'
                                  .trim(),
                          labelFontSize: localLabelSize,
                          valueFontSize: localValueSize,
                          leading: Icon(
                            Icons.directions_car_filled_rounded,
                            size: 20.sp,
                            color: AppColors.primary,
                          ),
                        ),
                        AppInfoRow(
                          label: 'الموعد',
                          value: job.preferredDate != null
                              ? _formatDate(job.preferredDate!)
                              : '-',
                          labelFontSize: localLabelSize,
                          valueFontSize: localValueSize,
                          leading: _rowAsset(AppAssets.calendarIcon),
                        ),
                      ],
                    ),
                  ),
                ),

                // الحالة
                SizedBox(
                  width: 100.w,
                  child: Container(
                    color: statusBg,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 45.r,
                          height: 45.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: statusColor, width: 2.5),
                          ),
                          child: Icon(
                            statusIcon,
                            color: statusColor,
                            size: 28.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          job.statusText ?? '-',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _rowAsset(String path) {
    return Image.asset(
      path,
      width: 20.sp,
      height: 20.sp,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) =>
          Icon(Icons.info_outline, size: 20.sp, color: AppColors.primary),
    );
  }
}