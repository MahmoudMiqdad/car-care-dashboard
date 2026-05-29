import 'package:flutter/material.dart';

class AppColors {
  static const Color primary   = Color(0xFF006989);
  static const Color secondary = Color(0xFFf3f7ec);
  static const Color accent    = Color(0xFFe88d67);
}

class ErrorStateWidget extends StatefulWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  State<ErrorStateWidget> createState() => _ErrorStateWidgetState();
}

class _ErrorStateWidgetState extends State<ErrorStateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<Offset>   _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _fadeAnim  = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end:   Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Icon ───────────────────────────────────────────
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wifi_off_rounded,
                    size: 44,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(height: 20),

                // ── Error message ───────────────────────────────────
                Text(
                  'حدث خطأ ما',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),

                // ── Retry button ────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: widget.onRetry,
                    icon: const Icon(Icons.refresh_rounded, size: 20),
                    label: const Text(
                      'حاول مجدداً',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}