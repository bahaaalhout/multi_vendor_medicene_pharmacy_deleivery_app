import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingState {
  final int currentIndex;
  OnboardingState({required this.currentIndex});
}

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState(currentIndex: 0));

  void updatePage(int index) => emit(OnboardingState(currentIndex: index));

  void nextPage(int lastIndex, Function() onLastPage) {
    if (state.currentIndex < lastIndex) {
      emit(OnboardingState(currentIndex: state.currentIndex + 1));
    } else {
      onLastPage();
    }
  }

  void skip(int lastIndex) => emit(OnboardingState(currentIndex: lastIndex));
}
