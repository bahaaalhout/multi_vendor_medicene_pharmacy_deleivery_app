import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';

class ReportIssueState {
  final OrderModel? selectedOrder;
  final String issueDescription;
  final bool isLoading;
  final bool isSubmitted;

  ReportIssueState({
    this.selectedOrder,
    this.issueDescription = '',
    this.isLoading = false,
    this.isSubmitted = false,
  });

  ReportIssueState copyWith({
    OrderModel? selectedOrder,
    String? issueDescription,
    bool? isLoading,
    bool? isSubmitted,
  }) {
    return ReportIssueState(
      selectedOrder: selectedOrder ?? this.selectedOrder,
      issueDescription: issueDescription ?? this.issueDescription,
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  bool get canSubmit => selectedOrder != null && issueDescription.isNotEmpty;
}

class ReportIssueCubit extends Cubit<ReportIssueState> {
  ReportIssueCubit() : super(ReportIssueState());

  void selectOrder(OrderModel order) {
    emit(state.copyWith(selectedOrder: order));
  }

  void updateDescription(String description) {
    emit(state.copyWith(issueDescription: description));
  }

  Future<void> submitIssue() async {
    if (!state.canSubmit) return;

    emit(state.copyWith(isLoading: true));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(
      isLoading: false,
      isSubmitted: true,
    ));
  }

  void reset() {
    emit(ReportIssueState());
  }
}

