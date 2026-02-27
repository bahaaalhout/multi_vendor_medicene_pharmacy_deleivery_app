abstract class AddMedicineState {}

class AddMedicineInitial extends AddMedicineState {}

class AddMedicineLoading extends AddMedicineState {}

class AddMedicineSuccess extends AddMedicineState {}

class AddMedicineError extends AddMedicineState {
  final String message;
  AddMedicineError(this.message);
}
