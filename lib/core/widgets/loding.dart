// app_loading_widget.dart
import 'dart:math' as math;
import 'package:car_care/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoadingWidget extends StatefulWidget {
  const AppLoadingWidget({super.key});

  @override
  State<AppLoadingWidget> createState() => _AppLoadingWidgetState();
}

class _AppLoadingWidgetState extends State<AppLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _gearCtrl;
  late AnimationController _wrenchCtrl;
  late AnimationController _ringCtrl;
  late AnimationController _dotsCtrl;

  @override
  void initState() {
    super.initState();

    _gearCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();

    _wrenchCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _ringCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();

    _dotsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _gearCtrl.dispose();
    _wrenchCtrl.dispose();
    _ringCtrl.dispose();
    _dotsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 30.w,
            height: 30.w,
            child: AnimatedBuilder(
              animation: Listenable.merge([_gearCtrl, _wrenchCtrl, _ringCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _MaintenancePainter(
                  gearAngle:    _gearCtrl.value * 2 * math.pi,
                  wrenchAngle:  (_wrenchCtrl.value - 0.5) * math.pi / 4, // -22° to +22°
                  ringProgress: _ringCtrl.value,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'جارٍ التحميل...',
            style: TextStyle(
              fontSize: 5.sp,
              color: Colors.grey.shade500,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 12.h),
          _DotsLoader(controller: _dotsCtrl),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
class _MaintenancePainter extends CustomPainter {
  final double gearAngle;
  final double wrenchAngle;
  final double ringProgress;

  _MaintenancePainter({
    required this.gearAngle,
    required this.wrenchAngle,
    required this.ringProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final accent  = AppColors.accent;
    final primary = AppColors.primary;

    // ── pulse rings ──
    for (final delay in [0.0, 0.65]) {
      final t = ((ringProgress - delay / 1.6) % 1.0).clamp(0.0, 1.0);
      final radius = cx * 0.48 + t * cx * 0.9;
      final opacity = (1 - t) * 0.55;
      if (opacity > 0) {
        canvas.drawCircle(
          Offset(cx, cy),
          radius,
          Paint()
            ..color = accent.withOpacity(opacity)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.2,
        );
      }
    }

    // ── gear ──
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(gearAngle);

    final gearR = cx * 0.40;
    final toothW = 3.0;
    final toothH = 5.0;

    // outer ring
    canvas.drawCircle(
      Offset.zero,
      gearR,
      Paint()
        ..color = accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    // 8 teeth
    final toothPaint = Paint()..color = accent;
    for (int i = 0; i < 8; i++) {
      canvas.save();
      canvas.rotate(i * math.pi / 4);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(0, -(gearR + toothH / 2)),
            width: toothW * 2,
            height: toothH,
          ),
          const Radius.circular(2),
        ),
        toothPaint,
      );
      canvas.restore();
    }

    // inner filled circle
    canvas.drawCircle(Offset.zero, gearR * 0.42, Paint()..color = accent);

    canvas.restore();

    // ── wrench ──
    canvas.save();
    final wrenchPivot = Offset(cx * 1.38, cy * 1.14);
    canvas.translate(wrenchPivot.dx, wrenchPivot.dy);
    canvas.rotate(wrenchAngle);

    final wp = Paint()..color = primary;

    // handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: const Offset(0, 0), width: 9, height: 26),
        const Radius.circular(4.5),
      ),
      wp,
    );
    // top ring
    canvas.drawCircle(
      const Offset(0, -13),
      6,
      Paint()
        ..color = primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5,
    );
    // bottom knob
    canvas.drawCircle(const Offset(0, 13), 5, wp);

    canvas.restore();

    // ── center dot ──
    canvas.drawCircle(Offset(cx, cy), 4.5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_MaintenancePainter old) =>
      old.gearAngle != gearAngle ||
      old.wrenchAngle != wrenchAngle ||
      old.ringProgress != ringProgress;
}

// ─────────────────────────────────────────────
class _DotsLoader extends StatelessWidget {
  final AnimationController controller;
  const _DotsLoader({required this.controller});

  Animation<double> _opacity(double delay) => Tween(begin: 0.25, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(delay, delay + 0.35, curve: Curves.easeInOut),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [0.0, 0.22, 0.44].map((d) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
      
              color: AppColors.accent.withOpacity(_opacity(d).value),
            ),
          );
        }).toList(),
      ),
    );
  }
}