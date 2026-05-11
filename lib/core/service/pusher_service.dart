import 'dart:async';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

typedef LocationCallback = void Function(double lat, double lng);

class PusherService {
  static final PusherService _instance = PusherService._internal();
  factory PusherService() => _instance;
  PusherService._internal();

  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();
  bool _initialized = false;

  // ─── Initialize مرة وحدة بس ───────────────────────────────────────────────
  Future<void> init() async {
    if (_initialized) return;
    await _pusher.init(
      // ← غير هاي القيم على حسب إعدادات Reverb عندك
      apiKey: 'your-reverb-app-key',
      cluster: 'mt1', // مو مهم مع Reverb بس لازم تنحط
      // wsost: '127.0.0.1', // أو IP السيرفر
      // wsPort: 8080,
      // wssPort: 8080,
      useTLS: false,
      onError: (message, code, error) {
        // ignore: avoid_print
        print('Pusher Error: $message');
      },
    );
    await _pusher.connect();
    _initialized = true;
  }

  // ─── Subscribe على channel الـ SOS لتتبع الفني ───────────────────────────
  Future<void> subscribeToSosTracking({
    required int sosId,
    required LocationCallback onLocationUpdate,
  }) async {
    await init();

    final channelName = 'sos.$sosId'; // ← اسم الـ channel من الباك

    await _pusher.subscribe(
      channelName: channelName,
      onEvent: (event) {
        if (event.eventName == 'technician.location.updated') {
          // الباك يرسل: {"lat": 33.33, "lng": 44.44}
          final data = event.data;
          if (data is Map) {
            final lat = double.tryParse(data['lat'].toString());
            final lng = double.tryParse(data['lng'].toString());
            if (lat != null && lng != null) {
              onLocationUpdate(lat, lng);
            }
          }
        }
      },
    );
  }

  // ─── Unsubscribe لما نطلع من الشاشة ──────────────────────────────────────
  Future<void> unsubscribeFromSos(int sosId) async {
    await _pusher.unsubscribe(channelName: 'sos.$sosId');
  }

  Future<void> disconnect() async {
    await _pusher.disconnect();
    _initialized = false;
  }
}
