import 'package:flutter/material.dart';

class AppSnackBar {
 //Success
  static void success(BuildContext context, String message) {
    _show(
      context,
      message: message,
      backgroundColor: Colors.green.shade600,
      icon: Icons.check_circle,
    );
  }

  //  Error
  static void error(BuildContext context, String message) {
    _show(
      context,
      message: message,
      backgroundColor: Colors.red.shade600,
      icon: Icons.error,
    );
  }


  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      
      SnackBar(
        
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}