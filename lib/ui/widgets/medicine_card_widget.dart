import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/models/MedicineCardWidget.dart';

class MedicineCardWidget extends StatelessWidget {
  final MedicineModel medicine;
  const MedicineCardWidget({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 171.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              medicine.imageAsset,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) {
                return Container(
                  color: const Color.fromRGBO(217, 217, 217, 1),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/medicine_placeholder.svg',
                    width: 36.w,
                    height: 36.h,
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 12.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.name,
                      style: textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(medicine.subtitle, style: textTheme.bodySmall),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              SvgPicture.asset(
                'assets/icons/medicine_voice.svg',
                width: 20.w,
                height: 20.h,
              ),
            ],
          ),

          SizedBox(height: 8.h),

          Row(
            children: [
              Text(
                '\$${medicine.price.toStringAsFixed(2)}',
                style: textTheme.bodyLarge,
              ),

              if (medicine.oldPrice != null) ...[
                SizedBox(width: 16.w),
                Text(
                  '\$${medicine.oldPrice!.toStringAsFixed(2)}',
                  style: textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
