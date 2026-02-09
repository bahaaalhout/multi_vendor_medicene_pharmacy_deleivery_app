// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

// class ProfileHeader extends StatelessWidget {
//   final VoidCallback onBack;
//   final VoidCallback onEdit;

//   const ProfileHeader({
//     super.key,
//     required this.onBack,
//     required this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: AppSizes.spacing40.h,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(AppSizes.borderRadius30.r),
//         border: Border.all(
//           color: AppColors.secondaryDarker1,
//           width: 6.w,
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Back Button
//           Container(
//             width: AppSizes.spacing60.w,
//             height: AppSizes.spacing60.h,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(AppSizes.borderRadius60.r),
//             ),
//             child: IconButton(
//               icon: Transform.rotate(
//                 angle: -90 * 3.14159 / 180,
//                 child: SvgPicture.asset(
//                   'assets/icons/arrow_up.svg',
//                   width: AppSizes.iconSize12.w,
//                   height: AppSizes.iconSize14.h,
//                   colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
//                 ),
//               ),
//               onPressed: onBack,
//               padding: EdgeInsets.zero,
//             ),
//           ),
          
//           SizedBox(width: AppSizes.spacing34.w),
          
//           // Profile Title
//           Text(
//             'Profile',
//             style: AppTextStyles.bold24.copyWith(
//               color: AppColors.primaryDarker,
//             ),
//           ),
          
//           SizedBox(width: AppSizes.spacing34.w),
          
//           // Edit Button
//           Container(
//             width: AppSizes.spacing60.w,
//             height: AppSizes.spacing60.h,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(
//                 color: AppColors.primaryLightActive,
//                 width: 1.w,
//               ),
//               borderRadius: BorderRadius.circular(AppSizes.borderRadius60.r),
//             ),
//             child: IconButton(
//               icon: SvgPicture.asset(
//                 'assets/icons/basil_edit-outline.png',
//                 width: AppSizes.iconSize24.w,
//                 height: AppSizes.iconSize24.h,
//                 colorFilter: const ColorFilter.mode(AppColors.primaryNormal, BlendMode.srcIn),
//               ),
//               onPressed: onEdit,
//               padding: EdgeInsets.zero,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }