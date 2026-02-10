import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SelectorTile extends StatelessWidget {
  const SelectorTile({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });
  final String title;
  final String value;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.5.h),
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: AppColors.neutralLightActive),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.medium16.copyWith(
                color: AppColors.neutralDarker,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                ),
                4.horizontalSpace,
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.primaryNormal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showSelectionSheet(
  BuildContext context,
  String title,
  List<String> options,
  Function(String) onSelected,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select $title",
              style: AppTextStyles.bold16.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final option = options[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(option, style: AppTextStyles.medium16),
                    onTap: () {
                      onSelected(option);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
