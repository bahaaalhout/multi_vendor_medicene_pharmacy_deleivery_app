// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryHistoryState {

 AsyncState<List<DeliveryModel>> get deliveries; HistoryPeriod get selectedPeriod; List<DeliveryModel> get filteredDeliveries;
/// Create a copy of DeliveryHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryHistoryStateCopyWith<DeliveryHistoryState> get copyWith => _$DeliveryHistoryStateCopyWithImpl<DeliveryHistoryState>(this as DeliveryHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryHistoryState&&(identical(other.deliveries, deliveries) || other.deliveries == deliveries)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&const DeepCollectionEquality().equals(other.filteredDeliveries, filteredDeliveries));
}


@override
int get hashCode => Object.hash(runtimeType,deliveries,selectedPeriod,const DeepCollectionEquality().hash(filteredDeliveries));

@override
String toString() {
  return 'DeliveryHistoryState(deliveries: $deliveries, selectedPeriod: $selectedPeriod, filteredDeliveries: $filteredDeliveries)';
}


}

/// @nodoc
abstract mixin class $DeliveryHistoryStateCopyWith<$Res>  {
  factory $DeliveryHistoryStateCopyWith(DeliveryHistoryState value, $Res Function(DeliveryHistoryState) _then) = _$DeliveryHistoryStateCopyWithImpl;
@useResult
$Res call({
 AsyncState<List<DeliveryModel>> deliveries, HistoryPeriod selectedPeriod, List<DeliveryModel> filteredDeliveries
});


$AsyncStateCopyWith<List<DeliveryModel>, $Res> get deliveries;

}
/// @nodoc
class _$DeliveryHistoryStateCopyWithImpl<$Res>
    implements $DeliveryHistoryStateCopyWith<$Res> {
  _$DeliveryHistoryStateCopyWithImpl(this._self, this._then);

  final DeliveryHistoryState _self;
  final $Res Function(DeliveryHistoryState) _then;

/// Create a copy of DeliveryHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deliveries = null,Object? selectedPeriod = null,Object? filteredDeliveries = null,}) {
  return _then(_self.copyWith(
deliveries: null == deliveries ? _self.deliveries : deliveries // ignore: cast_nullable_to_non_nullable
as AsyncState<List<DeliveryModel>>,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as HistoryPeriod,filteredDeliveries: null == filteredDeliveries ? _self.filteredDeliveries : filteredDeliveries // ignore: cast_nullable_to_non_nullable
as List<DeliveryModel>,
  ));
}
/// Create a copy of DeliveryHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AsyncStateCopyWith<List<DeliveryModel>, $Res> get deliveries {
  
  return $AsyncStateCopyWith<List<DeliveryModel>, $Res>(_self.deliveries, (value) {
    return _then(_self.copyWith(deliveries: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeliveryHistoryState].
extension DeliveryHistoryStatePatterns on DeliveryHistoryState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryHistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryHistoryState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryHistoryState value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryHistoryState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryHistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryHistoryState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AsyncState<List<DeliveryModel>> deliveries,  HistoryPeriod selectedPeriod,  List<DeliveryModel> filteredDeliveries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryHistoryState() when $default != null:
return $default(_that.deliveries,_that.selectedPeriod,_that.filteredDeliveries);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AsyncState<List<DeliveryModel>> deliveries,  HistoryPeriod selectedPeriod,  List<DeliveryModel> filteredDeliveries)  $default,) {final _that = this;
switch (_that) {
case _DeliveryHistoryState():
return $default(_that.deliveries,_that.selectedPeriod,_that.filteredDeliveries);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AsyncState<List<DeliveryModel>> deliveries,  HistoryPeriod selectedPeriod,  List<DeliveryModel> filteredDeliveries)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryHistoryState() when $default != null:
return $default(_that.deliveries,_that.selectedPeriod,_that.filteredDeliveries);case _:
  return null;

}
}

}

/// @nodoc


class _DeliveryHistoryState implements DeliveryHistoryState {
  const _DeliveryHistoryState({this.deliveries = const AsyncState.initial(), this.selectedPeriod = HistoryPeriod.all, final  List<DeliveryModel> filteredDeliveries = const []}): _filteredDeliveries = filteredDeliveries;
  

@override@JsonKey() final  AsyncState<List<DeliveryModel>> deliveries;
@override@JsonKey() final  HistoryPeriod selectedPeriod;
 final  List<DeliveryModel> _filteredDeliveries;
@override@JsonKey() List<DeliveryModel> get filteredDeliveries {
  if (_filteredDeliveries is EqualUnmodifiableListView) return _filteredDeliveries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredDeliveries);
}


/// Create a copy of DeliveryHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryHistoryStateCopyWith<_DeliveryHistoryState> get copyWith => __$DeliveryHistoryStateCopyWithImpl<_DeliveryHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryHistoryState&&(identical(other.deliveries, deliveries) || other.deliveries == deliveries)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&const DeepCollectionEquality().equals(other._filteredDeliveries, _filteredDeliveries));
}


@override
int get hashCode => Object.hash(runtimeType,deliveries,selectedPeriod,const DeepCollectionEquality().hash(_filteredDeliveries));

@override
String toString() {
  return 'DeliveryHistoryState(deliveries: $deliveries, selectedPeriod: $selectedPeriod, filteredDeliveries: $filteredDeliveries)';
}


}

/// @nodoc
abstract mixin class _$DeliveryHistoryStateCopyWith<$Res> implements $DeliveryHistoryStateCopyWith<$Res> {
  factory _$DeliveryHistoryStateCopyWith(_DeliveryHistoryState value, $Res Function(_DeliveryHistoryState) _then) = __$DeliveryHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncState<List<DeliveryModel>> deliveries, HistoryPeriod selectedPeriod, List<DeliveryModel> filteredDeliveries
});


@override $AsyncStateCopyWith<List<DeliveryModel>, $Res> get deliveries;

}
/// @nodoc
class __$DeliveryHistoryStateCopyWithImpl<$Res>
    implements _$DeliveryHistoryStateCopyWith<$Res> {
  __$DeliveryHistoryStateCopyWithImpl(this._self, this._then);

  final _DeliveryHistoryState _self;
  final $Res Function(_DeliveryHistoryState) _then;

/// Create a copy of DeliveryHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deliveries = null,Object? selectedPeriod = null,Object? filteredDeliveries = null,}) {
  return _then(_DeliveryHistoryState(
deliveries: null == deliveries ? _self.deliveries : deliveries // ignore: cast_nullable_to_non_nullable
as AsyncState<List<DeliveryModel>>,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as HistoryPeriod,filteredDeliveries: null == filteredDeliveries ? _self._filteredDeliveries : filteredDeliveries // ignore: cast_nullable_to_non_nullable
as List<DeliveryModel>,
  ));
}

/// Create a copy of DeliveryHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AsyncStateCopyWith<List<DeliveryModel>, $Res> get deliveries {
  
  return $AsyncStateCopyWith<List<DeliveryModel>, $Res>(_self.deliveries, (value) {
    return _then(_self.copyWith(deliveries: value));
  });
}
}

// dart format on
