import 'package:car_care/features/sos/presentation/widgets/sos_details/sos_details_section_card.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_details/sos_details_track_chip.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SosDetailsLocationCard extends StatelessWidget {
  const SosDetailsLocationCard({super.key, this.onTrackTapped});

  final VoidCallback? onTrackTapped;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SosDetailsSectionCard(
      title: l10n.sosDetailsCurrentLocation,
      bodyHeight: 200.h,
      clipBody: true,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PositionedDirectional(
            start: 12.w,
            bottom: 12.h,
            child: SosDetailsTrackChip(
              label: l10n.sosDetailsTrack,
              onTap: onTrackTapped,
            ),
          ),
        ],
      ),
    );
  }
}
