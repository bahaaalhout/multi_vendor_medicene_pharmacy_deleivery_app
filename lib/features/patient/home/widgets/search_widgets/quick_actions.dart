import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_text.dart';

class QuickActions extends StatefulWidget {
  const QuickActions({super.key});

  @override
  State<QuickActions> createState() => _QuickActionsState();
}

class _QuickActionsState extends State<QuickActions> {
  List<Map<String, dynamic>> actions = [
    {'icon': Icons.favorite, 'color': Colors.red, 'label': 'For you (4)'},
    {'icon': Icons.ac_unit, 'color': Colors.cyan, 'label': 'Cold medicine'},
    {'icon': Icons.refresh, 'color': Colors.brown, 'label': 'Reorder'},
    {
      'icon': Icons.local_shipping,
      'color': Colors.green,
      'label': 'Fast delivered',
    },
  ];

  void _removeItem(int index) {
    setState(() {
      actions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyledText(title: 'Quick Actions'),
        12.verticalSpace,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: actions.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;
            return BuildActionChip(
              icon: item['icon'],
              iconColor: item['color'],
              label: item['label'],
              onDelete: () => _removeItem(index),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class BuildActionChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onDelete;
  const BuildActionChip({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 11.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primaryLightActive),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: iconColor, size: 16),
          8.horizontalSpace,
          Text(
            label,
            style: AppTextStyles.medium14.copyWith(
              color: AppColors.primaryNormal,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          12.horizontalSpace,
          GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.close, color: Colors.black54, size: 18),
          ),
        ],
      ),
    );
  }
}
