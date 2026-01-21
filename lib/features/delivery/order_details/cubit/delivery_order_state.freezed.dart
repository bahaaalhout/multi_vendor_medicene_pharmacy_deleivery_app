// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryOrderState {

 bool get showProductDetails; DeliveryModel get delivery;
/// Create a copy of DeliveryOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryOrderStateCopyWith<DeliveryOrderState> get copyWith => _$DeliveryOrderStateCopyWithImpl<DeliveryOrderState>(this as DeliveryOrderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryOrderState&&(identical(other.showProductDetails, showProductDetails) || other.showProductDetails == showProductDetails)&&(identical(other.delivery, delivery) || other.delivery == delivery));
}


@override
int get hashCode => Object.hash(runtimeType,showProductDetails,delivery);

@override
String toString() {
  return 'DeliveryOrderState(showProductDetails: $showProductDetails, delivery: $delivery)';
}


}

/// @nodoc
abstract mixin class $DeliveryOrderStateCopyWith<$Res>  {
  factory $DeliveryOrderStateCopyWith(DeliveryOrderState value, $Res Function(DeliveryOrderState) _then) = _$DeliveryOrderStateCopyWithImpl;
@useResult
$Res call({
 bool showProductDetails, DeliveryModel delivery
});




}
/// @nodoc
class _$DeliveryOrderStateCopyWithImpl<$Res>
    implements $DeliveryOrderStateCopyWith<$Res> {
  _$DeliveryOrderStateCopyWithImpl(this._self, this._then);

  final DeliveryOrderState _self;
  final $Res Function(DeliveryOrderState) _then;

/// Create a copy of DeliveryOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showProductDetails = null,Object? delivery = null,}) {
  return _then(_self.copyWith(
showProductDetails: null == showProductDetails ? _self.showProductDetails : showProductDetails // ignore: cast_nullable_to_non_nullable
as bool,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as DeliveryModel,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryOrderState].
extension DeliveryOrderStatePatterns on DeliveryOrderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryOrderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryOrderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryOrderState value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryOrderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryOrderState value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryOrderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool showProductDetails,  DeliveryModel delivery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryOrderState() when $default != null:
return $default(_that.showProductDetails,_that.delivery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool showProductDetails,  DeliveryModel delivery)  $default,) {final _that = this;
switch (_that) {
case _DeliveryOrderState():
return $default(_that.showProductDetails,_that.delivery);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool showProductDetails,  DeliveryModel delivery)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryOrderState() when $default != null:
return $default(_that.showProductDetails,_that.delivery);case _:
  return null;

}
}

}

/// @nodoc


class _DeliveryOrderState implements DeliveryOrderState {
  const _DeliveryOrderState({this.showProductDetails = false, required this.delivery});
  

@override@JsonKey() final  bool showProductDetails;
@override final  DeliveryModel delivery;

/// Create a copy of DeliveryOrderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryOrderStateCopyWith<_DeliveryOrderState> get copyWith => __$DeliveryOrderStateCopyWithImpl<_DeliveryOrderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryOrderState&&(identical(other.showProductDetails, showProductDetails) || other.showProductDetails == showProductDetails)&&(identical(other.delivery, delivery) || other.delivery == delivery));
}


@override
int get hashCode => Object.hash(runtimeType,showProductDetails,delivery);

@override
String toString() {
  return 'DeliveryOrderState(showProductDetails: $showProductDetails, delivery: $delivery)';
}


}

/// @nodoc
abstract mixin class _$DeliveryOrderStateCopyWith<$Res> implements $DeliveryOrderStateCopyWith<$Res> {
  factory _$DeliveryOrderStateCopyWith(_DeliveryOrderState value, $Res Function(_DeliveryOrderState) _then) = __$DeliveryOrderStateCopyWithImpl;
@override @useResult
$Res call({
 bool showProductDetails, DeliveryModel delivery
});




}
/// @nodoc
class __$DeliveryOrderStateCopyWithImpl<$Res>
    implements _$DeliveryOrderStateCopyWith<$Res> {
  __$DeliveryOrderStateCopyWithImpl(this._self, this._then);

  final _DeliveryOrderState _self;
  final $Res Function(_DeliveryOrderState) _then;

/// Create a copy of DeliveryOrderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showProductDetails = null,Object? delivery = null,}) {
  return _then(_DeliveryOrderState(
showProductDetails: null == showProductDetails ? _self.showProductDetails : showProductDetails // ignore: cast_nullable_to_non_nullable
as bool,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as DeliveryModel,
  ));
}


}

// dart format on
