import 'package:car_care/features/sos/presentation/widgets/sos_details/sos_details_section_card.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_details/sos_details_track_chip.dart';
import 'package:car_care/features/user_fuel_orders/presentation/widgets/fuel_order_details/fuel_order_details_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class FuelOrderDetailsLocationCard extends StatelessWidget {
  const FuelOrderDetailsLocationCard({super.key, required this.order});

  final FuelOrderDetailsUiModel order;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasLocation = order.latitude != null && order.longitude != null;
    final location = hasLocation
        ? LatLng(order.latitude!, order.longitude!)
        : const LatLng(33.3152, 44.3661);

    return SosDetailsSectionCard(
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
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.car_care.app',
                ),
                if (hasLocation)
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: location,
                        radius: 80,
                        color: const Color(0x3345B733),
                        borderColor: const Color(0xFF45B733),
                        borderStrokeWidth: 1,
                      ),
                    ],
                  ),
                if (hasLocation)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: location,
                        width: 24,
                        height: 24,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF45B733),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          PositionedDirectional(
            start: 12.w,
            bottom: 12.h,
            child: SosDetailsTrackChip(
              label: l10n.sosDetailsTrack,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
