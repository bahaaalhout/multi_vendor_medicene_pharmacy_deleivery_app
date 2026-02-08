import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/quick_actions.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/recent_section.dart';

class DefultSearchScreen extends StatelessWidget {
  const DefultSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        16.verticalSpace,

        QuickActions(),
        16.verticalSpace,
        RecentSection(medicine: medicineData[0]),
      ],
    );
  }
}
