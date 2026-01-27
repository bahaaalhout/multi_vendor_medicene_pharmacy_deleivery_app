import 'package:flutter_bloc/flutter_bloc.dart';

enum HelpSection {
  faqs,
  contactSupport,
  orderIssues,
  legalInfo,
  reportIssue,
}

class HelpState {
  final HelpSection? expandedSection;

  HelpState({
    this.expandedSection,
  });

  HelpState copyWith({
    HelpSection? expandedSection,
  }) {
    return HelpState(
      expandedSection: expandedSection ?? this.expandedSection,
    );
  }

  bool isExpanded(HelpSection section) {
    return expandedSection == section;
  }
}

class HelpCubit extends Cubit<HelpState> {
  HelpCubit() : super(HelpState());

  void toggleSection(HelpSection section) {
    if (state.isExpanded(section)) {
      emit(state.copyWith(expandedSection: null));
    } else {
      emit(state.copyWith(expandedSection: section));
    }
  }
}

