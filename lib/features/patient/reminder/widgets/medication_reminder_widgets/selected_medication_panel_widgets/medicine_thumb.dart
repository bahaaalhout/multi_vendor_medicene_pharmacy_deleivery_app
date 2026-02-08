import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineThumb extends StatelessWidget {
  final String imageUrl;
  const MedicineThumb({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: imageUrl.isEmpty
          ? const Icon(Icons.medication_outlined)
          : Image.network(
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.medication_outlined),
            ),
    );
  }
}
