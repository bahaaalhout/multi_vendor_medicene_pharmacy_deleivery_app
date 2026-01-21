import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/models/delivery_model.dart';

part 'driver_state.freezed.dart';

@freezed
abstract class DriverState with _$DriverState {
  const factory DriverState({
    @Default(true) bool isOnline,
    @Default('Mohammed') String driverName,
    @Default('26 Salah El Din St., Gaza') String driverLocation,
    String? driverImageUrl,
    @Default(true) bool hasReviewAlert,
    @Default(<DeliveryModel>[]) List<DeliveryModel> availableDeliveries,
  }) = _DriverState;
}
