import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/filter_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/search_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/search_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/screens/defult_search_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/screens/filter_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/screens/onsubmit_search_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/screens/ontyping_search_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(pharmacies: pharmacies),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: const [
                    NavigateBackButton(),
                    SizedBox(width: 12),
                    StyledText(title: 'Search'),
                  ],
                ),

                12.verticalSpace,

                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    final bool isTyping =
                        state is OnSearchResult &&
                        state.mode == SearchMode.typing;

                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Search for medicine, pharmacy..',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isTyping ? Icons.close : Icons.mic,
                                  color: AppColors.primaryNormal,
                                ),
                                onPressed: isTyping
                                    ? () {
                                        _controller.clear();
                                        context.read<SearchCubit>().onTyping(
                                          '',
                                        );
                                      }
                                    : null,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: AppColors.primaryNormal,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              context.read<SearchCubit>().onTyping(value);
                            },
                            onSubmitted: (value) {
                              context.read<SearchCubit>().onSubmit(value);
                            },
                          ),
                        ),

                        8.horizontalSpace,

                        if (state is OnSearchResult &&
                            state.mode == SearchMode.submitted)
                          InkWell(
                            onTap: () {
                              final currentFilters =
                                  state.activeFilters ?? FilterModel.initial();

                              showFilterModal(
                                context,
                                _controller.text,
                                currentFilters,
                              );
                            },
                            child: Container(
                              width: 56,
                              height: 56,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryLightActive,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/filter.svg',
                                width: 24.w,
                                height: 24.h,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is OnSearchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is OnSearchError) {
                        return Center(child: Text(state.message));
                      }

                      if (state is OnSearchResult &&
                          state.mode == SearchMode.typing) {
                        return OntypingSearchScreen(
                          textInput: _controller.text,
                          results: state.results,
                        );
                      }

                      if (state is OnSearchResult &&
                          state.mode == SearchMode.submitted) {
                        return OnsubmitSearchScreen();
                      }

                      return const DefultSearchScreen();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
