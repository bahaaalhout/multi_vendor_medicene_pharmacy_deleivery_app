import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final String location;
  final String phoneCode;
  final String phone;
  final String dateOfBirth;
  final String password;
  final bool isLoading;

  EditProfileState({
    this.firstName = 'Mohammed',
    this.lastName = 'Bassam',
    this.email = 'example@gmail.com',
    this.location = 'Al-Rimal area, Gaza Strip',
    this.phoneCode = '+20',
    this.phone = '1234567890',
    this.dateOfBirth = '20-4-2002',
    this.password = '••••••••',
    this.isLoading = false,
  });

  EditProfileState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? location,
    String? phoneCode,
    String? phone,
    String? dateOfBirth,
    String? password,
    bool? isLoading,
  }) {
    return EditProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      location: location ?? this.location,
      phoneCode: phoneCode ?? this.phoneCode,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileState());

  void updateFirstName(String value) {
    emit(state.copyWith(firstName: value));
  }

  void updateLastName(String value) {
    emit(state.copyWith(lastName: value));
  }

  void updateEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void updateLocation(String value) {
    emit(state.copyWith(location: value));
  }

  void updatePhone(String value) {
    emit(state.copyWith(phone: value));
  }

  void updateDateOfBirth(String value) {
    emit(state.copyWith(dateOfBirth: value));
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void setLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }

  Future<void> saveChanges() async {
    setLoading(true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }
}

