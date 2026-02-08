import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/filter_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/filter_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/filter_state.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/search_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/bottom_buttons.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/filter_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/option_section.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/range_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/rating_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/selector_tile.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/switch_tile.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key, required this.currentSearchQuery});
  final String currentSearchQuery;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          if (state is FilterLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FilterSuccess) {
            final filter = state.model;
            final cubit = context.read<FilterCubit>();

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
              child: Column(
                children: [
                  const FilterHeader(),
                  20.verticalSpace,
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        SelectorTile(
                          title: 'Category',

                          value: filter.category ?? 'All',
                          onTap: () {
                            final List<String> categories = medicineData
                                .map((e) => e.type)
                                .toSet()
                                .toList();

                            showSelectionSheet(
                              context,
                              'Category',
                              categories,
                              (selected) {
                                context.read<FilterCubit>().update(
                                  filter.copyWith(category: selected),
                                );
                              },
                            );
                          },
                        ),
                        16.verticalSpace,
                        SelectorTile(
                          title: 'Brand',
                          value: filter.brand ?? 'All',
                          onTap: () {
                            final List<String> brands = medicineData
                                .map((e) => e.brand)
                                .toSet()
                                .toList();

                            showSelectionSheet(context, 'Brand', brands, (
                              selected,
                            ) {
                              context.read<FilterCubit>().update(
                                filter.copyWith(brand: selected),
                              );
                            });
                          },
                        ),
                        16.verticalSpace,

                        RangeSection(
                          title: 'Price Range',
                          values: filter.priceRange,
                          min: 1,
                          max: 1000,

                          labelPrefix: r'$',
                          onChanged: (v) =>
                              cubit.update(filter.copyWith(priceRange: v)),
                        ),
                        16.verticalSpace,
                        RangeSection(
                          title: 'Pharmacy  Distance',
                          values: filter.distanceRange,
                          min: 1,
                          max: 20,
                          labelSuffix: ' km',
                          onChanged: (v) =>
                              cubit.update(filter.copyWith(distanceRange: v)),
                        ),
                        16.verticalSpace,
                        PrescriptionSection(),
                        16.verticalSpace,
                        RatingSection(
                          selectedRating: filter.rating,
                          onChanged: (v) =>
                              cubit.update(filter.copyWith(rating: v)),
                        ),
                        16.verticalSpace,
                        SwitchTile(
                          title: 'Availability',
                          subtitle: 'In stock only',
                          value: filter.inStockOnly,
                          onChanged: (v) =>
                              cubit.update(filter.copyWith(inStockOnly: v)),
                        ),
                        16.verticalSpace,
                        SwitchTile(
                          title: 'Offers',
                          subtitle: 'On sale',
                          value: filter.onSale,
                          onChanged: (v) =>
                              cubit.update(filter.copyWith(onSale: v)),
                        ),
                        40.verticalSpace,
                        BottomButtons(
                          onApply: () {
                            context.read<SearchCubit>().applyFilters(
                              filter,
                              currentSearchQuery,
                            );
                            Navigator.pop(context);
                          },
                          onClear: () => cubit.reset(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

void showFilterModal(
  BuildContext context,
  String currentSearchQuery,
  FilterModel filters,
) {
  final searchCubit = context.read<SearchCubit>();

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: searchCubit),
          BlocProvider(
            create: (context) => FilterCubit(filters)..init(filters),
          ),
        ],
        child: FilterScreen(currentSearchQuery: currentSearchQuery),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(color: Colors.transparent),
            ),
          ),

          SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
