import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/onboarding/controller/onboarding_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/onboarding/data/onboarding_content.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/onboarding/view/widgets/navigatation_buttons_onboard.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return PageView.builder(
              controller: _controller,
              itemCount: onboardingPages.length,
              onPageChanged: (index) {
                context.read<OnboardingCubit>().updatePage(index);
              },
              itemBuilder: (context, index) {
                final page = onboardingPages[index];
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(page.image, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          200.verticalSpace,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    page.title,
                                    style: AppTextStyles.semiBold30.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                12.verticalSpace,
                                Text(
                                  page.subtitle,
                                  style: AppTextStyles.semiBold18.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          NavigationButtonsOnboard(
                            controller: _controller,
                            index: index,
                            state: state,
                          ),
                          64.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
