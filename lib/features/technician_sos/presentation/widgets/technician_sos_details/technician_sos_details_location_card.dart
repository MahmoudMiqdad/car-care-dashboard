// ignore_for_file: deprecated_member_use

import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/features/technician_sos/presentation/cubit/share_technician_location_cubit/share_technician_location_sos_cubit.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/technician_sos_details/technician_sos_details_section_card.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/technician_sos_details/technician_sos_details_track_chip.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/technician_sos_map_widget.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

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
    final l10n = context.l10n;
    final hasLocation = lat != null && lng != null;
    final location =
        hasLocation ? LatLng(lat!, lng!) : const LatLng(33.3152, 44.3661);

    return SosTechnicianDetailsSectionCard(
      title: l10n.sosDetailsCurrentLocation,
      bodyHeight: 200.h,
      clipBody: true,
      child: Stack(
        fit: StackFit.expand,
        children: [
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

          if (isAccepted)
            PositionedDirectional(
              start: 12.w,
              bottom: 12.h,
              child: SosTechnicianDetailsTrackChip(
                label: 'ابدأ التوجه',
                onTap: () => _openTechnicianMap(context),
              ),
            ),

          if (!isAccepted)
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
    );
  }

  void _openTechnicianMap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => getIt<ShareTechnicianLocationSosCubit>(),
        child: _TechnicianNavigationSheet(
          sosId: sosId,
          userLat: lat,
          userLng: lng,
        ),
      ),
    );
  }
}

class _TechnicianNavigationSheet extends StatelessWidget {
  final int sosId;
  final double? userLat;
  final double? userLng;

  const _TechnicianNavigationSheet({
    required this.sosId,
    this.userLat,
    this.userLng,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                const Icon(Icons.navigation, color: Colors.teal),
                SizedBox(width: 8.w),
                Text(
                  'التوجه للعميل',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: TechnicianMapWidget(
              sosId: sosId,
              userLat: userLat,
              userLng: userLng,
            ),
          ),
        ],
      ),
    );
  }
}