import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/models/MedicineModel.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/models/pharmacyOfferModel.dart';

class MedicineCardWidget extends StatelessWidget {
  final PharmacyOfferModel offer;
  const MedicineCardWidget({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          height: 170.h,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Image.asset(
            offer.medicine.imageUrls[0],
            errorBuilder: (_, _, _) {
              return Center(
                child: SvgPicture.asset(
                  'assets/images/medicine_placeholder.svg',
                  width: 48.w,
                  height: 48.h,
                ),
              );
            },
          ),
        ),

        SizedBox(height: 12.h),
        // SizedBox(width: 4.w),

        // SvgPicture.asset(
        //   'assets/images/medicine_voice.svg',
        //   width: 20.w,
        //   height: 20.h,
        // ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${offer.medicine.brandName} ${offer.medicine.strength}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
                  ),
                  Text(
                    '${formLabel(offer.medicine.form)} – ${offer.medicine.quantity} ${formLabel(offer.medicine.form)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ),

            SizedBox(width: 4.w),

            SvgPicture.asset('assets/images/medicine_voice.svg'),
          ],
        ),

        SizedBox(height: 8.h),

        Row(
          children: [
            Text(
              '\$${(offer.discountedPrice ?? offer.price).toStringAsFixed(2)}',
              style: textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
            ),
            if (offer.discountedPrice != null) ...[
              SizedBox(width: 16.w),
              Text(
                '\$${offer.price.toStringAsFixed(2)}',
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  decoration: TextDecoration.lineThrough,
                  color: const Color.fromRGBO(0, 0, 0, 0.35),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  String formLabel(FormType form) {
    switch (form) {
      case FormType.tablet:
        return 'Tablets';
      case FormType.syrup:
        return 'Syrup';
      case FormType.capsule:
        return 'Capsules';
    }
  }
}
