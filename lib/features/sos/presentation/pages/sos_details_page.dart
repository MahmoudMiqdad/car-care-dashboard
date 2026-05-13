// ignore_for_file: constant_identifier_names
import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/const.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_details/sos_details_body.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const String SosDetailsVehicleTitle = 'سابا سيدان ٢٠٣';
const String SosDetailsPlateNumber = '328797';
const String SosDetailsTechnicianName = 'خالد الخالد';
const String SosDetailsDescription =
    'عطل في العجلات الأربعة و كسر في الجنط الداخلي للعجلة  '
;

class SosDetailsPage extends StatelessWidget {
  const SosDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: l10n.sosDetailsTitle,
          showBackButton: true,
          backgroundColor: AppColors.carWashTeal,
          onBackTapped: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(Routes.sos);
            }
          },
        ),
        body: ImageBackground(
          child: SosDetailsBody(
            vehicleTitle: SosDetailsVehicleTitle,
            plateNumber: SosDetailsPlateNumber,
            technicianName: SosDetailsTechnicianName,
            description: SosDetailsDescription,
          ),
        ),
      ),
    );
  }
}
