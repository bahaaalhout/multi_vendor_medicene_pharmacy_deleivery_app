import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/address_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/nearby_pharmacy_widget.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/title_of_headers.dart';

class NearbyPharmacies extends StatelessWidget {
  const NearbyPharmacies({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleOfHeaders(title: 'Nearby Pharmacies', navigateToPage: () {}),
        SizedBox(height: 12),
        SizedBox(
          height: 250.h,
          child: ListView.separated(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return NearbyPharmacyWidget(
                imagePath: 'assets/images/pills.png',
                pharmacyModel: PharmacyModel(
                  id: '1',
                  name: 'Ah',
                  address: AddressModel(
                    id: '1',
                    street: 'Al Nasr',
                    area: 'Al Rimal',
                    city: 'Gaza',
                    country: 'Palestine',
                    postalCode: '970',
                  ),
                  rating: 4.5,
                  reviewCount: 100,
                  image: ' assets/images/pills.png',
                  deliveryFee: 0,
                  deliveryTime: '15 min',
                  distance: 10,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10.w);
            },
          ),
        ),
      ],
    );
  }
}
