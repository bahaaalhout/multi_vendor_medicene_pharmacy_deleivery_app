import 'package:flutter_bloc/flutter_bloc.dart';

enum PasswordStrength {
  weak,
  medium,
  strong,
  excellent,
}

class ChangePasswordState {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final bool showCurrentPassword;
  final bool showNewPassword;
  final bool showConfirmPassword;
  final PasswordStrength passwordStrength;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasMinLength;
  final bool isLoading;

  ChangePasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.showCurrentPassword = false,
    this.showNewPassword = false,
    this.showConfirmPassword = false,
    this.passwordStrength = PasswordStrength.weak,
    this.hasUppercase = false,
    this.hasLowercase = false,
    this.hasMinLength = false,
    this.isLoading = false,
  });

  ChangePasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    bool? showCurrentPassword,
    bool? showNewPassword,
    bool? showConfirmPassword,
    PasswordStrength? passwordStrength,
    bool? hasUppercase,
    bool? hasLowercase,
    bool? hasMinLength,
    bool? isLoading,
  }) {
    return ChangePasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      hasLowercase: hasLowercase ?? this.hasLowercase,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordState());

  void updateCurrentPassword(String value) {
    emit(state.copyWith(currentPassword: value));
  }

  void updateNewPassword(String value) {
    final hasUpper = value.contains(RegExp(r'[A-Z]'));
    final hasLower = value.contains(RegExp(r'[a-z]'));
    final hasMin = value.length >= 8;

    PasswordStrength strength = PasswordStrength.weak;
    if (hasUpper && hasLower && hasMin && value.length >= 12) {
      strength = PasswordStrength.excellent;
    } else if (hasUpper && hasLower && hasMin) {
      strength = PasswordStrength.strong;
    } else if ((hasUpper || hasLower) && hasMin) {
      strength = PasswordStrength.medium;
    }

    emit(state.copyWith(
      newPassword: value,
      hasUppercase: hasUpper,
      hasLowercase: hasLower,
      hasMinLength: hasMin,
      passwordStrength: strength,
    ));
  }

  void updateConfirmPassword(String value) {
    emit(state.copyWith(confirmPassword: value));
  }

  void toggleCurrentPasswordVisibility() {
    emit(state.copyWith(showCurrentPassword: !state.showCurrentPassword));
  }

  void toggleNewPasswordVisibility() {
    emit(state.copyWith(showNewPassword: !state.showNewPassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  void setLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }

  Future<void> changePassword() async {
    if (state.currentPassword.isEmpty ||
        state.newPassword.isEmpty ||
        state.confirmPassword.isEmpty) {
      return;
    }

    if (state.newPassword != state.confirmPassword) {
      return;
    }

    setLoading(true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }
}

