import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/onboarding/controller/onboarding_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/onboarding/data/onboarding_content.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class NavigationButtonsOnboard extends StatelessWidget {
  const NavigationButtonsOnboard({
    super.key,
    required PageController controller,
    required this.index,
    required this.state,
  }) : _controller = controller;

  final PageController _controller;
  final int index;
  final OnboardingState state;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _controller.jumpToPage(onboardingPages.length - 1);

            context.read<OnboardingCubit>().skip(onboardingPages.length - 1);
            context.go(AppRoutes.select);
          },
          child: Text(
            index != onboardingPages.length - 1 ? "Skip" : "Next",
            style: AppTextStyles.semiBold16.copyWith(color: Colors.white),
          ),
        ),

        GestureDetector(
          onTap: () {
            if (state.currentIndex < onboardingPages.length - 1) {
              _controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );

              context.read<OnboardingCubit>().updatePage(
                state.currentIndex + 1,
              );
            } else {
              context.go(AppRoutes.select);
            }
          },
          child: SvgPicture.asset('assets/icons/next_button_onboard.svg'),
        ),

        Row(
          children: List.generate(
            onboardingPages.length,
            (dotIndex) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: 6.h,
              width: state.currentIndex == dotIndex ? 27.w : 4.w,
              decoration: BoxDecoration(
                color: state.currentIndex == dotIndex
                    ? Colors.white
                    : Colors.white54,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
