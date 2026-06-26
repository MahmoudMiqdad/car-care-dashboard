import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/maintenance_request_details_entity.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_info_row.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_section_card.dart';
import 'package:flutter/material.dart';

class RequestInfoCard extends StatelessWidget {
  const RequestInfoCard({super.key, required this.data});

  final MaintenanceRequestDetailsDataEntity data;

  static String _formatDate(DateTime d) =>
      '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return SosDetailsSectionCard(
      title: 'بيانات الطلب',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SosDetailsInfoRow(
            iconAsset: AppAssets.technicianJobNotesIcon,
            label: 'الوصف',
            value: data.description,
          ),
          SosDetailsInfoRow(
            iconAsset: AppAssets.calendarIcon,
            label: 'الموعد المفضل',
            value: data.preferredDate != null
                ? _formatDate(data.preferredDate!)
                : '-',
          ),
          SosDetailsInfoRow(
            iconAsset: AppAssets.technicianJobNotesIcon,
            label: 'الأولوية',
            value: data.priorityText,
          ),
          SosDetailsInfoRow(
            iconAsset: AppAssets.technicianJobNotesIcon,
            label: 'تاريخ الإنشاء',
            value: data.createdAgo ?? '-',
          ),
        ],
      ),
    );
  }
}