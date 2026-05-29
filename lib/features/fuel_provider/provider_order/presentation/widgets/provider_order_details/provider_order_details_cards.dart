import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/fuel_provider/provider_order/presentation/widgets/provider_order_details/provider_order_details_ui_model.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_info_row.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_section_card.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class ProviderOrderDetailsPendingBanner extends StatelessWidget {
  const ProviderOrderDetailsPendingBanner({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.warning, width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Icon(
            Icons.hourglass_empty_rounded,
            color: AppColors.warning,
            size: 22.sp,
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.warning,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProviderOrderDetailsOrderCard extends StatelessWidget {
  const ProviderOrderDetailsOrderCard({super.key, required this.order});

  final ProviderOrderDetailsUiModel order;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SosDetailsSectionCard(
      title: l10n.sosDetailsRequestData,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  order.vehicleTitle,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                SosDetailsInfoRow(
                  iconAsset: AppAssets.plateNumberIcon,
                  label: l10n.sosDetailsPlateNumberLabel,
                  value: order.plateNumber,
                ),
                SosDetailsInfoRow(
                  iconAsset: AppAssets.serviceFuel,
                  label: l10n.fuel,
                  value: order.fuel,
                ),
                SosDetailsInfoRow(
                  iconAsset: AppAssets.fuelOrderMoneyIcon,
                  label: l10n.price,
                  value: order.price,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          CircleAvatar(
            radius: 44.r,
            backgroundColor: AppColors.lightSurface,
            backgroundImage: order.vehicleImageAsset != null
                ? AssetImage(order.vehicleImageAsset!)
                : const AssetImage(AppAssets.technicianJobVehicleIcon),
          ),
        ],
      ),
    );
  }
}

class ProviderOrderDetailsCustomerCard extends StatelessWidget {
  const ProviderOrderDetailsCustomerCard({super.key, required this.order});

  final ProviderOrderDetailsUiModel order;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SosDetailsSectionCard(
      title: l10n.providerOrderDetailsCustomerSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            order.customerName,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                Image.asset(
                  AppAssets.iconPhoneCall,
                  width: 20.w,
                  height: 20.w,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.phone_in_talk_rounded,
                    size: 15.sp,
                    color: AppColors.carWashTeal,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  order.customerPhone,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProviderOrderDetailsLocationCard extends StatelessWidget {
  const ProviderOrderDetailsLocationCard({
    super.key,
    required this.order,
    required this.isSharingLocation,
    required this.onSharingChanged,
  });

  final ProviderOrderDetailsUiModel order;
  final bool isSharingLocation;
  final ValueChanged<bool> onSharingChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasLocation = order.latitude != null && order.longitude != null;
    final location = hasLocation
        ? LatLng(order.latitude!, order.longitude!)
        : const LatLng(33.3152, 44.3661);

    return SosDetailsSectionCard(
      title: l10n.sosDetailsCurrentLocation,
      clipBody: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 180.h,
            child: IgnorePointer(
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
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 14.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    isSharingLocation
                        ? l10n.providerOrderDetailsShareLocationOn
                        : l10n.providerOrderDetailsShareLocationOff,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ),
                Switch(
                  value: isSharingLocation,
                  onChanged: onSharingChanged,
                  activeThumbColor: AppColors.white,
                  activeTrackColor: AppColors.carWashTeal,
                  inactiveThumbColor: AppColors.white,
                  inactiveTrackColor: AppColors.lightBorder,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
