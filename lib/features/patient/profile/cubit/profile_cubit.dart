import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileState {
  final bool medicineRemindersEnabled;
  final bool notificationsEnabled;
  final bool offersEnabled;
  final bool orderTrackingEnabled;
  final bool ratingRequestsEnabled;

  ProfileState({
    this.medicineRemindersEnabled = true,
    this.notificationsEnabled = true,
    this.offersEnabled = true,
    this.orderTrackingEnabled = true,
    this.ratingRequestsEnabled = false,
  });

  ProfileState copyWith({
    bool? medicineRemindersEnabled,
    bool? notificationsEnabled,
    bool? offersEnabled,
    bool? orderTrackingEnabled,
    bool? ratingRequestsEnabled,
  }) {
    return ProfileState(
      medicineRemindersEnabled:
          medicineRemindersEnabled ?? this.medicineRemindersEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      offersEnabled: offersEnabled ?? this.offersEnabled,
      orderTrackingEnabled: orderTrackingEnabled ?? this.orderTrackingEnabled,
      ratingRequestsEnabled:
          ratingRequestsEnabled ?? this.ratingRequestsEnabled,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  void toggleMedicineReminders(bool value) {
    emit(state.copyWith(medicineRemindersEnabled: value));
  }

  void toggleNotifications(bool value) {
    emit(state.copyWith(notificationsEnabled: value));
  }

  void toggleOffers(bool value) {
    emit(state.copyWith(offersEnabled: value));
  }

  void toggleOrderTracking(bool value) {
    emit(state.copyWith(orderTrackingEnabled: value));
  }

  void toggleRatingRequests(bool value) {
    emit(state.copyWith(ratingRequestsEnabled: value));
  }
  
}

