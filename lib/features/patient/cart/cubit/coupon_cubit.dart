import 'package:flutter_bloc/flutter_bloc.dart';

class CouponCubit extends Cubit<bool> {
  CouponCubit() : super(false);

  void onTextChanged(String value) {
    emit(value.trim().isNotEmpty);
  }

  void submitCoupon(String coupon) {}
}
