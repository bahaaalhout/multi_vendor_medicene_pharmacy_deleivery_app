import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/models/delivery_model.dart';

part 'delivery_home_state.freezed.dart';

@freezed
abstract class DeliveryHomeState with _$DeliveryHomeState {
  const factory DeliveryHomeState({
    @Default(true) bool isOnline,
    @Default('Mohammed') String driverName,
    @Default('26 Salah El Din St., Gaza') String driverLocation,
    String? driverImageUrl,
    @Default(true) bool hasReviewAlert,
    @Default(<DeliveryModel>[]) List<DeliveryModel> availableDeliveries,
  }) = _DriverState;
}
