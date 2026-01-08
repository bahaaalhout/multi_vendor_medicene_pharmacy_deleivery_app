import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/widgets/section_bar.dart';
import 'pharmacy_card.dart';

class PharmaciesSection extends StatelessWidget {
  const PharmaciesSection({super.key, required this.items, this.onPressedCard, required this.onPressedSeeAll});

  final List<Pharmacy> items;
  final void Function(Pharmacy)? onPressedCard;
  final void Function()? onPressedSeeAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionBar(sectionTitle: 'Nearby pharmacies', onPressed: onPressedSeeAll),
        SizedBox(height: 16.h),
        SizedBox(
          height: 191.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => onPressedCard?.call(item),
                child: PharmacyCard.fromPharmacy(pharmacy: item),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
          ),
        ),
      ],
    );
  }
}
