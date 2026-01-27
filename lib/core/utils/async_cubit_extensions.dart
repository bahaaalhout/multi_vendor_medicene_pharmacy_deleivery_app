import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/async_state.dart';

/// Extension on Cubit that provides unified async operation handling
/// This eliminates the need to manually write loading → success/error patterns
extension AsyncCubitExtensions<T> on Cubit<T> {
  /// Executes an async operation with automatic loading, success, and error state management
  /// 
  /// [call] - The async operation to execute (e.g., API call, database query)
  /// [stateUpdater] - Function to update the state with the new async state
  /// 
  /// Example usage:
  /// ```dart
  /// void loadData() => tryExecute(
  ///   asyncOperation: () => apiService.fetchData(),        // The async operation
  ///   stateUpdater: (newState) => emit(state.copyWith(data: newState)) // Update state
  /// );
  /// ```
  Future<void> tryExecute<TData>({
    required Future<TData> Function() call,
    required void Function(AsyncState<TData>) stateUpdater,
  }) async {
    // Set loading state
    stateUpdater(AsyncState.loading());

    try {
      // Execute the async operation
      final result = await call();
      
      // Set success state with the result
      stateUpdater(AsyncState.success(result));
    } catch (e, stackTrace) {
      // Set error state with error message
      final errorMessage = e.toString();
      stateUpdater(AsyncState.error(errorMessage));
      
      // Log the error with stack trace for debugging
      print('Async operation failed: $errorMessage');
      print('Stack trace: $stackTrace');
    }
  }
}