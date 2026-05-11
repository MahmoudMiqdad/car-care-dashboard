import 'dart:async';
import 'package:car_care/features/technician/technician_location/presentation/cubit/technician_location_cubit.dart';
import 'package:car_care/features/technician/technician_location/presentation/cubit/technician_location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class TechnicianLocationService {
  StreamSubscription<Position>? _positionSub;

  Future<void> startTracking({
    required int sosId,
    required TechnicianLocationCubit cubit,
  }) async {
    final permission = await _checkPermission();
    if (!permission) return;

    _positionSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((position) {
      // ← shareLocation للـ SOS
      cubit.shareLocation(
        sosId: sosId,
        lat: position.latitude,
        lng: position.longitude,
      );
    });
  }

  void stopTracking() {
    _positionSub?.cancel();
    _positionSub = null;
  }

  Future<bool> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }
}

// ─── ويدجت جهة الفني داخل SOS ────────────────────────────────────────────

class TechnicianTrackingWidget extends StatefulWidget {
  final int sosId;

  const TechnicianTrackingWidget({super.key, required this.sosId});

  @override
  State<TechnicianTrackingWidget> createState() =>
      _TechnicianTrackingWidgetState();
}

class _TechnicianTrackingWidgetState extends State<TechnicianTrackingWidget> {
  final TechnicianLocationService _service = TechnicianLocationService();
  bool _isTracking = false;

  @override
  void initState() {
    super.initState();
    _startAuto();
  }

  Future<void> _startAuto() async {
    await _service.startTracking(
      sosId: widget.sosId,
      cubit: context.read<TechnicianLocationCubit>(),
    );
    if (mounted) setState(() => _isTracking = true);
  }

  @override
  void dispose() {
    _service.stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TechnicianLocationCubit, TechnicianLocationState>(
      listener: (context, state) {
        // ← ShareLocationError للـ SOS
        if (state is ShareLocationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطأ في إرسال الموقع: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _isTracking ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isTracking ? Colors.green : Colors.grey,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isTracking ? Icons.location_on : Icons.location_off,
              color: _isTracking ? Colors.green : Colors.grey,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              _isTracking ? 'موقعك يُرسل للعميل' : 'جاري التفعيل...',
              style: TextStyle(
                color: _isTracking ? Colors.green.shade700 : Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
