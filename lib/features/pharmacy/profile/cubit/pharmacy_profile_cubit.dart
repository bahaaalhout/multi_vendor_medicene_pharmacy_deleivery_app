import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/profile/cubit/pharmacy_profile_state.dart';

class PharmacyProfileCubit extends Cubit<PharmacyProfileState> {
  PharmacyProfileCubit() : super(PharmacyProfileState());

  void toggleAcceptNewOrder(bool value) {
    emit(state.copyWith(acceptNewOrder: value));
  }

  void updateAddress(String address) {
    emit(state.copyWith(address: address));
  }

  void updateWorkingHoursFrom(String from) {
    emit(state.copyWith(workingHoursFrom: from));
  }

  void updateWorkingHoursTo(String to) {
    emit(state.copyWith(workingHoursTo: to));
  }

  void updatePhoneCode(String code) {
    emit(state.copyWith(phoneCode: code));
  }

  void updatePhoneNumber(String number) {
    emit(state.copyWith(phoneNumber: number));
  }
}
