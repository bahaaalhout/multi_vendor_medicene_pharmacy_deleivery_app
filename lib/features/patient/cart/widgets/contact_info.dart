import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/cubit/expand_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/contact_info_widget.dart';

class MyExpandWidget extends StatelessWidget {
  const MyExpandWidget({super.key, required this.widget, required this.title});
  final Widget widget;
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpandCubit, bool>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Text(title, style: AppTextStyles.bold20),
                Spacer(),
                InkWell(
                  onTap: () {
                    context.read<ExpandCubit>().toggle();
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.r),
                      border: Border.all(
                        width: 1.w,
                        color: AppColors.primaryLightActive,
                      ),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: null,
                      icon: state == false
                          ? SvgPicture.asset('assets/icons/arrow_up.svg')
                          : SvgPicture.asset('assets/icons/arrow_down.svg'),
                    ),
                  ),
                ),
              ],
            ),
            if (state == false) widget,
          ],
        );
      },
    );
  }
}
