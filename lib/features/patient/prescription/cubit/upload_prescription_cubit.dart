import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadPrescriptionState {
  final File? selectedImage;
  final bool isLoading;
  final String? errorMessage;

  UploadPrescriptionState({
    this.selectedImage,
    this.isLoading = false,
    this.errorMessage,
  });

  UploadPrescriptionState copyWith({
    File? selectedImage,
    bool? isLoading,
    String? errorMessage,
  }) {
    return UploadPrescriptionState(
      selectedImage: selectedImage ?? this.selectedImage,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class UploadPrescriptionCubit extends Cubit<UploadPrescriptionState> {
  UploadPrescriptionCubit() : super(UploadPrescriptionState());

  void setSelectedImage(File? image) {
    emit(state.copyWith(selectedImage: image, errorMessage: null));
  }

  void setLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }

  void setError(String? error) {
    emit(state.copyWith(errorMessage: error, isLoading: false));
  }

  void clearImage() {
    emit(state.copyWith(selectedImage: null, errorMessage: null));
  }
}

