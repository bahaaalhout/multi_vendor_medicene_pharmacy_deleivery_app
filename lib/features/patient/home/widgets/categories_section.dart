import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/category_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/category_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/title_of_headers.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, required this.categories});
  final List<CategoryModel> categories;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleOfHeaders(title: 'Categories', navigateToPage: () {}),
        SizedBox(height: 12),
        SizedBox(
          height: 155.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryItem(categoryModel: categories[index]);
            },
          ),
        ),
      ],
    );
  }
}
