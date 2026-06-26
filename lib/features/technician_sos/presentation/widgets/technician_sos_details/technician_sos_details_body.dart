// ignore_for_file: deprecated_member_use
import 'package:car_care/core/constants/app_constants.dart';
import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/buttons/app_button_widget.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/technician_sos/domain/entities/technician_sos_entity.dart';
import 'package:car_care/features/technician_sos/presentation/cubit/share_technician_location_cubit/share_technician_location_sos_cubit.dart';
import 'package:car_care/features/technician_sos/presentation/cubit/technician_sos_cubit/technician_sos_cubit.dart';
import 'package:car_care/features/technician_sos/presentation/cubit/technician_sos_cubit/technician_sos_state.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/technician_sos_details/technician_sos_details_request_card.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/technician_sos_details/technician_sos_details_section_card.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/technician_sos_details/technician_sos_details_status_banner.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/technician_sos_map_widget.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class SosTechnicianDetailsBody extends StatefulWidget {
  const SosTechnicianDetailsBody({
    super.key,
    required this.sos,
    required this.vehicleTitle,
    required this.plateNumber,
    required this.ownerName,
    required this.description,
    this.onCancelTapped,
    this.isMyRequest = false,
  });

  final TechnicianSosEntity sos;
  final String vehicleTitle;
  final String plateNumber;
  final String ownerName;
  final String description;
  final VoidCallback? onCancelTapped;
  final bool isMyRequest;

  @override
  State<SosTechnicianDetailsBody> createState() =>
      _SosTechnicianDetailsBodyState();
}
class _SosTechnicianDetailsBodyState extends State<SosTechnicianDetailsBody> {
  bool _acceptedLocally = false;
  bool _mapOpened = false; // ← منع فتح الخريطة مرتين

  bool get _isAccepted =>
      _acceptedLocally ||
      widget.sos.status == 'accepted' ||
      widget.sos.status == 'in_progress';

  void _openTechnicianMap() {
    if (_mapOpened) return; // ← منع التكرار
    _mapOpened = true;
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => BlocProvider(
          create: (_) => getIt<ShareTechnicianLocationSosCubit>(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('التوجه للعميل'),
              backgroundColor: AppColors.carWashTeal,
              foregroundColor: Colors.white,
            ),
            body: TechnicianMapWidget(
              sosId: widget.sos.id!,
              userLat: widget.sos.lat,
              userLng: widget.sos.lng,
            ),
          ),
        ),
      ),
    ).then((_) {
      // ← لما يرجع من الخريطة reset الـ flag
      if (mounted) setState(() => _mapOpened = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<TechnicianSosCubit, TechnicianSosState>(
      listener: (context, state) {
        if (state is TechnicianError) {
          AppSnackBar.error(context, state.message);
        }
        if (state is TechnicianAccepted) {
          setState(() => _acceptedLocally = true);
          _openTechnicianMap();
        }
        // ← لما يجي TechnicianRequestLoaded بعد القبول
        // الـ _acceptedLocally بيبقى true فالواجهة بتبقى صح
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
              SosTechnicianDetailsStatusBanner(label: widget.sos.statusText!),
              SizedBox(height: 14.h),

              SosTechnicianDetailsRequestCard(
                vehicleTitle: widget.vehicleTitle,
                plateNumber: widget.plateNumber,
                technicianName: widget.ownerName,
                description: widget.description,
              ),
              SizedBox(height: 14.h),

              if (!widget.isMyRequest) ...[
                _LocationPreviewCard(
                  sosId: widget.sos.id!,
                  lat: widget.sos.lat,
                  lng: widget.sos.lng,
                  isAccepted: _isAccepted,
                  onNavigateTap: _openTechnicianMap,
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
                                .acceptRequest(widget.sos.id!),
                        text: isLoading ? 'جاري القبول...' : 'قبول الطلب',
                        backgroundColor: AppColors.carWashTeal,
                        textColor: AppColors.white,
                        borderRadius: 14.r,
                        height: 52.h,
                      );
                    },
                  ),

                SizedBox(height: 12.h),
              ],

              // if (widget.sos.canCancel == true)
              //   AppButton(
              //     onPressed: widget.onCancelTapped ?? () {},
              //     text: l10n.sosDetailsCancelRequest,
              //     backgroundColor: AppColors.reservationConfirmOrange,
              //     textColor: AppColors.white,
              //     borderRadius: 14.r,
              //     height: 52.h,
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
// ─── معاينة الخريطة الصغيرة ───────────────────────────────────────────────
class _LocationPreviewCard extends StatelessWidget {
  const _LocationPreviewCard({
    required this.sosId,
    this.lat,
    this.lng,
    this.isAccepted = false,
    this.onNavigateTap,
  });

  final int sosId;
  final double? lat;
  final double? lng;
  final bool isAccepted;
  final VoidCallback? onNavigateTap;

  @override
  Widget build(BuildContext context) {
    final hasLocation = lat != null && lng != null;
    final location = hasLocation
        ? LatLng(lat!, lng!)
        : const LatLng(33.3152, 44.3661);

    return SosTechnicianDetailsSectionCard(
      title: 'موقع العميل',
      bodyHeight: 200.h,
      clipBody: true,
      child: GestureDetector(
        onTap: isAccepted ? onNavigateTap : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ─── الخريطة ─────────────────────────────────────────
            IgnorePointer(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: location,
                  initialZoom: 14,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.none,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.car_care.app',
                  ),
                  if (hasLocation)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: location,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // ─── بعد القبول: زر التوجه ──────────────────────────
            if (isAccepted)
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: GestureDetector(
                  onTap: onNavigateTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.carWashTeal,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.navigation, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'ابدأ التوجه للعميل',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // ─── قبل القبول: رسالة ──────────────────────────────
            if (!isAccepted)
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'اقبل الطلب لتبدأ التوجه للعميل',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
