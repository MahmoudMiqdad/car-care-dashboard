import 'package:car_care/features/sos/data/models/tracking_techniciain_model.dart';
import 'package:car_care/features/sos/presentation/cubit/tracking_cubit/tracking_cubit.dart';
import 'package:car_care/features/sos/presentation/cubit/tracking_cubit/tracking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// ويدجت مستقل - ضعه أينما تريد في الـ UI
/// مثال: SosMapWidget(sosId: sos.id!)
class SosMapWidget extends StatefulWidget {
  final int sosId;

  const SosMapWidget({super.key, required this.sosId});

  @override
  State<SosMapWidget> createState() => _SosMapWidgetState();
}

class _SosMapWidgetState extends State<SosMapWidget> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // حمّل التراكينج لما الويدجت يفتح
    context.read<TrackingCubit>().loadTracking(widget.sosId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingCubit, TrackingState>(
      builder: (context, state) {
        if (state is TrackingLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TrackingError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 40),
                const SizedBox(height: 8),
                Text(state.message, textAlign: TextAlign.center),
                TextButton(
                  onPressed: () =>
                      context.read<TrackingCubit>().loadTracking(widget.sosId),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (state is TrackingLoaded) {
          return _buildMap(state);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMap(TrackingLoaded state) {
    final data = state.data;

    // موقع اليوزر (من الـ SOS الأصلي)
    final userLocation = (data.lat != null && data.lng != null)
        ? LatLng(data.lat!, data.lng!)
        : null;

    // موقع الفني اللحظي (من Pusher) أو الأخير من API
    final techLocation = state.liveLocation;

    // نقاط مسار الفني
    final path = data.path
            ?.map((p) => LatLng(p.lat, p.lng))
            .toList() ??
        [];

    // إضافة الموقع اللحظي لآخر المسار
    if (techLocation != null) {
      path.add(techLocation);
    }

    // المركز الأولي للخريطة
    final center = techLocation ?? userLocation ?? const LatLng(33.3, 44.4);

    // حرّك الخريطة للموقع الجديد تلقائياً
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (techLocation != null) {
        _mapController.move(techLocation, _mapController.camera.zoom);
      }
    });

    return Stack(
      children: [
        // ─── الخريطة ────────────────────────────────────────────────
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: center,
            initialZoom: 14,
          ),
          children: [
            // Tile Layer
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.car_care.app',
            ),

            // مسار الفني (خط أزرق)
            if (path.length > 1)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: path,
                    color: Colors.blue.withOpacity(0.7),
                    strokeWidth: 4,
                  ),
                ],
              ),

            // الماركرات
            MarkerLayer(
              markers: [
                // 📍 موقع اليوزر (أحمر)
                if (userLocation != null)
                  Marker(
                    point: userLocation,
                    width: 50,
                    height: 50,
                    child: const _UserMarker(),
                  ),

                // 🔧 موقع الفني (أزرق - يتحرك مع Pusher)
                if (techLocation != null)
                  Marker(
                    point: techLocation,
                    width: 60,
                    height: 60,
                    child: const _TechnicianMarker(),
                  ),
              ],
            ),
          ],
        ),

        // ─── معلومات الفني (أعلى الخريطة) ──────────────────────────
        if (data.lat != null)
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: _TechnicianInfoCard(state: state),
          ),

        // ─── زر تمركز ───────────────────────────────────────────────
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton.small(
            onPressed: () {
              final target = techLocation ?? userLocation;
              if (target != null) {
                _mapController.move(target, 15);
              }
            },
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}

// ─── ماركر اليوزر ─────────────────────────────────────────────────────────

class _UserMarker extends StatelessWidget {
  const _UserMarker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(Icons.person_pin, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'أنت',
            style: TextStyle(color: Colors.white, fontSize: 9),
          ),
        ),
      ],
    );
  }
}

// ─── ماركر الفني ──────────────────────────────────────────────────────────

class _TechnicianMarker extends StatefulWidget {
  const _TechnicianMarker();

  @override
  State<_TechnicianMarker> createState() => _TechnicianMarkerState();
}

class _TechnicianMarkerState extends State<_TechnicianMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    // نبضة بسيطة لما الماركر يتحرك
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);
    _scaleAnim = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: const Icon(Icons.build_circle, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'الفني',
              style: TextStyle(color: Colors.white, fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── كارد معلومات الفني ───────────────────────────────────────────────────

class _TechnicianInfoCard extends StatelessWidget {
  final TrackingLoaded state;

  const _TechnicianInfoCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final isLive = state.liveLocation != null;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // أيقونة حالة الـ live
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: isLive ? Colors.green : Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                isLive ? 'الفني في الطريق - تتبع مباشر' : 'انتظار تحديث الموقع...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isLive ? Colors.green.shade700 : Colors.orange.shade700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
