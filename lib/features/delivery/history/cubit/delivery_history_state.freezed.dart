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

 List<DeliveryModel> get deliveries; HistoryPeriod get selectedPeriod; bool get isLoading;
/// Create a copy of DeliveryHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryHistoryStateCopyWith<DeliveryHistoryState> get copyWith => _$DeliveryHistoryStateCopyWithImpl<DeliveryHistoryState>(this as DeliveryHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryHistoryState&&const DeepCollectionEquality().equals(other.deliveries, deliveries)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(deliveries),selectedPeriod,isLoading);

@override
String toString() {
  return 'DeliveryHistoryState(deliveries: $deliveries, selectedPeriod: $selectedPeriod, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $DeliveryHistoryStateCopyWith<$Res>  {
  factory $DeliveryHistoryStateCopyWith(DeliveryHistoryState value, $Res Function(DeliveryHistoryState) _then) = _$DeliveryHistoryStateCopyWithImpl;
@useResult
$Res call({
 List<DeliveryModel> deliveries, HistoryPeriod selectedPeriod, bool isLoading
});




}
/// @nodoc
class _$DeliveryHistoryStateCopyWithImpl<$Res>
    implements $DeliveryHistoryStateCopyWith<$Res> {
  _$DeliveryHistoryStateCopyWithImpl(this._self, this._then);

  final DeliveryHistoryState _self;
  final $Res Function(DeliveryHistoryState) _then;

/// Create a copy of DeliveryHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deliveries = null,Object? selectedPeriod = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
deliveries: null == deliveries ? _self.deliveries : deliveries // ignore: cast_nullable_to_non_nullable
as List<DeliveryModel>,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as HistoryPeriod,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DeliveryModel> deliveries,  HistoryPeriod selectedPeriod,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryHistoryState() when $default != null:
return $default(_that.deliveries,_that.selectedPeriod,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DeliveryModel> deliveries,  HistoryPeriod selectedPeriod,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _DeliveryHistoryState():
return $default(_that.deliveries,_that.selectedPeriod,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DeliveryModel> deliveries,  HistoryPeriod selectedPeriod,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryHistoryState() when $default != null:
return $default(_that.deliveries,_that.selectedPeriod,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _DeliveryHistoryState implements DeliveryHistoryState {
  const _DeliveryHistoryState({final  List<DeliveryModel> deliveries = const [], this.selectedPeriod = HistoryPeriod.all, this.isLoading = true}): _deliveries = deliveries;
  

 final  List<DeliveryModel> _deliveries;
@override@JsonKey() List<DeliveryModel> get deliveries {
  if (_deliveries is EqualUnmodifiableListView) return _deliveries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deliveries);
}

@override@JsonKey() final  HistoryPeriod selectedPeriod;
@override@JsonKey() final  bool isLoading;

/// Create a copy of DeliveryHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryHistoryStateCopyWith<_DeliveryHistoryState> get copyWith => __$DeliveryHistoryStateCopyWithImpl<_DeliveryHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryHistoryState&&const DeepCollectionEquality().equals(other._deliveries, _deliveries)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_deliveries),selectedPeriod,isLoading);

@override
String toString() {
  return 'DeliveryHistoryState(deliveries: $deliveries, selectedPeriod: $selectedPeriod, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$DeliveryHistoryStateCopyWith<$Res> implements $DeliveryHistoryStateCopyWith<$Res> {
  factory _$DeliveryHistoryStateCopyWith(_DeliveryHistoryState value, $Res Function(_DeliveryHistoryState) _then) = __$DeliveryHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 List<DeliveryModel> deliveries, HistoryPeriod selectedPeriod, bool isLoading
});




}
/// @nodoc
class __$DeliveryHistoryStateCopyWithImpl<$Res>
    implements _$DeliveryHistoryStateCopyWith<$Res> {
  __$DeliveryHistoryStateCopyWithImpl(this._self, this._then);

  final _DeliveryHistoryState _self;
  final $Res Function(_DeliveryHistoryState) _then;

/// Create a copy of DeliveryHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deliveries = null,Object? selectedPeriod = null,Object? isLoading = null,}) {
  return _then(_DeliveryHistoryState(
deliveries: null == deliveries ? _self._deliveries : deliveries // ignore: cast_nullable_to_non_nullable
as List<DeliveryModel>,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as HistoryPeriod,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
