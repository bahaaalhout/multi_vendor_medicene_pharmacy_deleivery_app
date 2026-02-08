import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_state.freezed.dart';

@freezed
abstract class AsyncState<T> with _$AsyncState<T> {
  const factory AsyncState.initial() = Initial<T>;
  const factory AsyncState.loading() = Loading<T>;
  const factory AsyncState.success(T data) = Success<T>;
  const factory AsyncState.error(String message) = Error<T>;
}

extension AsyncStateExtension<T> on AsyncState<T> {
  bool get isLoading => maybeWhen(
        loading: () => true,
        orElse: () => false,
      );

  bool get isSuccess => maybeWhen(
        success: (_) => true,
        orElse: () => false,
      );

  bool get isError => maybeWhen(
        error: (_) => true,
        orElse: () => false,
      );

  T? get data => maybeWhen(
        success: (data) => data,
        orElse: () => null,
      );

  String? get errorMessage => maybeWhen(
        error: (message) => message,
        orElse: () => null,
      );
}