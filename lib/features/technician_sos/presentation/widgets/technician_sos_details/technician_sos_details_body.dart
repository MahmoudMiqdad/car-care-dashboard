// ignore_for_file: deprecated_member_use

import 'package:car_care/core/constants/app_constants.dart';
import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/buttons/app_button_widget.dart';
import 'package:car_care/features/technician_sos/domain/entities/technician_sos_entity.dart';
import 'package:car_care/features/technician_sos/presentation/cubit/share_technician_location_cubit/share_technician_location_sos_cubit.dart';
import 'package:car_care/features/technician_sos/presentation/cubit/technician_sos_cubit/technician_sos_cubit.dart';
import 'package:car_care/features/technician_sos/presentation/cubit/technician_sos_cubit/technician_sos_state.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/technician_sos_details/technician_sos_details_request_card.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/technician_sos_details/technician_sos_details_status_banner.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SosTechnicianDetailsBody extends StatelessWidget {
  const SosTechnicianDetailsBody({
    super.key,
    required this.sos,
    required this.vehicleTitle,
    required this.plateNumber,
    required this.ownerName,
    required this.description,
    this.onCancelTapped,
    this.isMyRequest = false, // ← جديد: true = myRequests، false = available
  });

  final TechnicianSosEntity sos;
  final String vehicleTitle;
  final String plateNumber;
  final String ownerName;
  final String description;
  final VoidCallback? onCancelTapped;
  final bool isMyRequest; // ← جديد

  bool get _isAccepted =>
      sos.status == 'accepted' || sos.status == 'in_progress';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<TechnicianSosCubit, TechnicianSosState>(
      listener: (context, state) {
        if (state is TechnicianError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red.shade600,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            AppConstants.pageHorizontal,
            16.h,
            AppConstants.pageHorizontal,
            24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          
              SosTechnicianDetailsStatusBanner(
                label: sos.statusText!,
              ),
              SizedBox(height: 14.h),

          
              SosTechnicianDetailsRequestCard(
                vehicleTitle: vehicleTitle,
                plateNumber: plateNumber,
                technicianName: ownerName,
                description: description,
              ),
              SizedBox(height: 14.h),

         
              if (!isMyRequest) ...[
                SosTechnicianDetailsLocationCard(
                  sosId: sos.id!,
                  lat: sos.lat,
                  lng: sos.lng,
                  isAccepted: _isAccepted,
                ),
                SizedBox(height: 22.h),

              
                if (!_isAccepted)
                  BlocBuilder<TechnicianSosCubit, TechnicianSosState>(
                    builder: (context, state) {
                      final isLoading = state is TechnicianLoading;
                      return AppButton(
                        onPressed: isLoading
                            ? null
                            : () => context
                                .read<TechnicianSosCubit>()
                                .acceptRequest(sos.id!),
                        text: isLoading ? 'جاري القبول...' : 'قبول الطلب',
                        backgroundColor: AppColors.carWashTeal,
                        textColor: AppColors.white,
                        borderRadius: 14.r,
                        height: 52.h,
                      );
                    },
                  ),

                if (!_isAccepted) SizedBox(height: 12.h),
              ],

          
              if (sos.canCancel == true)
                AppButton(
                  onPressed: onCancelTapped ?? () {},
                  text: l10n.sosDetailsCancelRequest,
                  backgroundColor: AppColors.reservationConfirmOrange,
                  textColor: AppColors.white,
                  borderRadius: 14.r,
                  height: 52.h,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

//  Location Card مع Bottom Sheet 

class SosTechnicianDetailsLocationCard extends StatelessWidget {
  const SosTechnicianDetailsLocationCard({
    super.key,
    required this.sosId,
    this.lat,
    this.lng,
    this.isAccepted = false,
  });

  final int sosId;
  final double? lat;
  final double? lng;
  final bool isAccepted;

  @override
  Widget build(BuildContext context) {
 
    return SosTechnicianDetailsLocationCard(
      sosId: sosId,
      lat: lat,
      lng: lng,
      isAccepted: isAccepted,
    );
  }
}