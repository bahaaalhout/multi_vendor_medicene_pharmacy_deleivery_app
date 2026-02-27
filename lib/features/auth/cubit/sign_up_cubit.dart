import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/cubit/sign_up_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/auth.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthService authService;

  SignupCubit(this.authService) : super(const SignupState());

  void nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  void confirmPasswordChanged(String value) {
    emit(state.copyWith(confirmPassword: value));
  }

  Future<void> register() async {
    if (state.name.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty ||
        state.confirmPassword.isEmpty) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          errorMessage: "All fields are required",
        ),
      );
      return;
    }

    if (state.password != state.confirmPassword) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          errorMessage: "Passwords do not match",
        ),
      );
      return;
    }

    emit(state.copyWith(status: SignupStatus.loading));

    try {
      await authService.register(
        name: state.name,
        email: state.email,
        password: state.password,
      );

      emit(state.copyWith(status: SignupStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          errorMessage: e.toString().replaceAll("Exception: ", ""),
        ),
      );
    }
  }
}
