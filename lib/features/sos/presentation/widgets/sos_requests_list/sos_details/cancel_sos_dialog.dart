import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_care/core/theme/app_colors.dart';

class CancelSosDialog extends StatefulWidget {
  const CancelSosDialog({super.key});

  @override
  State<CancelSosDialog> createState() => _CancelSosDialogState();
}

class _CancelSosDialogState extends State<CancelSosDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      contentPadding: EdgeInsets.zero,
      // العنوان بالأزرق مثل الصورة
      title: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A5FA8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14.r),
            topRight: Radius.circular(14.r),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: const Text(
          'Cancel SOS',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ما سبب إلغاء الطلب ؟',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: _controller,
                maxLines: 3,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: 'ادخل هنا سبب إلغاء طلب الطوارئ ...',
                  hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  contentPadding: EdgeInsets.all(10.w),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // تأكيد — يرجع النص
        TextButton(
          onPressed: () {
            final reason = _controller.text.trim();
            Navigator.of(context).pop(reason.isEmpty ? null : reason);
          },
          child: Text(
            'تأكيد',
            style: TextStyle(
              color: const Color(0xFF1A5FA8),
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),
        // تراجع
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(
            'تراجع',
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}