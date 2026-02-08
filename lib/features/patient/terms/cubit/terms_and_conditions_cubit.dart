import 'package:flutter_bloc/flutter_bloc.dart';

class TermsAndConditionsState {
  final bool isAgreed;

  TermsAndConditionsState({
    this.isAgreed = false,
  });

  TermsAndConditionsState copyWith({
    bool? isAgreed,
  }) {
    return TermsAndConditionsState(
      isAgreed: isAgreed ?? this.isAgreed,
    );
  }
}

class TermsAndConditionsCubit extends Cubit<TermsAndConditionsState> {
  TermsAndConditionsCubit() : super(TermsAndConditionsState());

  void toggleAgreement(bool value) {
    emit(state.copyWith(isAgreed: value));
  }
}

