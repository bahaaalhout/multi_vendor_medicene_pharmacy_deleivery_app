// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryHomeState {

 bool get isOnline; String get driverName; String get driverLocation; String? get driverImageUrl; bool get hasReviewAlert; List<DeliveryModel> get availableDeliveries;
/// Create a copy of DeliveryHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryHomeStateCopyWith<DeliveryHomeState> get copyWith => _$DeliveryHomeStateCopyWithImpl<DeliveryHomeState>(this as DeliveryHomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryHomeState&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverLocation, driverLocation) || other.driverLocation == driverLocation)&&(identical(other.driverImageUrl, driverImageUrl) || other.driverImageUrl == driverImageUrl)&&(identical(other.hasReviewAlert, hasReviewAlert) || other.hasReviewAlert == hasReviewAlert)&&const DeepCollectionEquality().equals(other.availableDeliveries, availableDeliveries));
}


@override
int get hashCode => Object.hash(runtimeType,isOnline,driverName,driverLocation,driverImageUrl,hasReviewAlert,const DeepCollectionEquality().hash(availableDeliveries));

@override
String toString() {
  return 'DeliveryHomeState(isOnline: $isOnline, driverName: $driverName, driverLocation: $driverLocation, driverImageUrl: $driverImageUrl, hasReviewAlert: $hasReviewAlert, availableDeliveries: $availableDeliveries)';
}


}

/// @nodoc
abstract mixin class $DeliveryHomeStateCopyWith<$Res>  {
  factory $DeliveryHomeStateCopyWith(DeliveryHomeState value, $Res Function(DeliveryHomeState) _then) = _$DeliveryHomeStateCopyWithImpl;
@useResult
$Res call({
 bool isOnline, String driverName, String driverLocation, String? driverImageUrl, bool hasReviewAlert, List<DeliveryModel> availableDeliveries
});




}
/// @nodoc
class _$DeliveryHomeStateCopyWithImpl<$Res>
    implements $DeliveryHomeStateCopyWith<$Res> {
  _$DeliveryHomeStateCopyWithImpl(this._self, this._then);

  final DeliveryHomeState _self;
  final $Res Function(DeliveryHomeState) _then;

/// Create a copy of DeliveryHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOnline = null,Object? driverName = null,Object? driverLocation = null,Object? driverImageUrl = freezed,Object? hasReviewAlert = null,Object? availableDeliveries = null,}) {
  return _then(_self.copyWith(
isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,driverName: null == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String,driverLocation: null == driverLocation ? _self.driverLocation : driverLocation // ignore: cast_nullable_to_non_nullable
as String,driverImageUrl: freezed == driverImageUrl ? _self.driverImageUrl : driverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,hasReviewAlert: null == hasReviewAlert ? _self.hasReviewAlert : hasReviewAlert // ignore: cast_nullable_to_non_nullable
as bool,availableDeliveries: null == availableDeliveries ? _self.availableDeliveries : availableDeliveries // ignore: cast_nullable_to_non_nullable
as List<DeliveryModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryHomeState].
extension DeliveryHomeStatePatterns on DeliveryHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverState value)  $default,){
final _that = this;
switch (_that) {
case _DriverState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverState value)?  $default,){
final _that = this;
switch (_that) {
case _DriverState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isOnline,  String driverName,  String driverLocation,  String? driverImageUrl,  bool hasReviewAlert,  List<DeliveryModel> availableDeliveries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverState() when $default != null:
return $default(_that.isOnline,_that.driverName,_that.driverLocation,_that.driverImageUrl,_that.hasReviewAlert,_that.availableDeliveries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isOnline,  String driverName,  String driverLocation,  String? driverImageUrl,  bool hasReviewAlert,  List<DeliveryModel> availableDeliveries)  $default,) {final _that = this;
switch (_that) {
case _DriverState():
return $default(_that.isOnline,_that.driverName,_that.driverLocation,_that.driverImageUrl,_that.hasReviewAlert,_that.availableDeliveries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isOnline,  String driverName,  String driverLocation,  String? driverImageUrl,  bool hasReviewAlert,  List<DeliveryModel> availableDeliveries)?  $default,) {final _that = this;
switch (_that) {
case _DriverState() when $default != null:
return $default(_that.isOnline,_that.driverName,_that.driverLocation,_that.driverImageUrl,_that.hasReviewAlert,_that.availableDeliveries);case _:
  return null;

}
}

}

/// @nodoc


class _DriverState implements DeliveryHomeState {
  const _DriverState({this.isOnline = true, this.driverName = 'Mohammed', this.driverLocation = '26 Salah El Din St., Gaza', this.driverImageUrl, this.hasReviewAlert = true, final  List<DeliveryModel> availableDeliveries = const <DeliveryModel>[]}): _availableDeliveries = availableDeliveries;
  

@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  String driverName;
@override@JsonKey() final  String driverLocation;
@override final  String? driverImageUrl;
@override@JsonKey() final  bool hasReviewAlert;
 final  List<DeliveryModel> _availableDeliveries;
@override@JsonKey() List<DeliveryModel> get availableDeliveries {
  if (_availableDeliveries is EqualUnmodifiableListView) return _availableDeliveries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableDeliveries);
}


/// Create a copy of DeliveryHomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverStateCopyWith<_DriverState> get copyWith => __$DriverStateCopyWithImpl<_DriverState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverState&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverLocation, driverLocation) || other.driverLocation == driverLocation)&&(identical(other.driverImageUrl, driverImageUrl) || other.driverImageUrl == driverImageUrl)&&(identical(other.hasReviewAlert, hasReviewAlert) || other.hasReviewAlert == hasReviewAlert)&&const DeepCollectionEquality().equals(other._availableDeliveries, _availableDeliveries));
}


@override
int get hashCode => Object.hash(runtimeType,isOnline,driverName,driverLocation,driverImageUrl,hasReviewAlert,const DeepCollectionEquality().hash(_availableDeliveries));

@override
String toString() {
  return 'DeliveryHomeState(isOnline: $isOnline, driverName: $driverName, driverLocation: $driverLocation, driverImageUrl: $driverImageUrl, hasReviewAlert: $hasReviewAlert, availableDeliveries: $availableDeliveries)';
}


}

/// @nodoc
abstract mixin class _$DriverStateCopyWith<$Res> implements $DeliveryHomeStateCopyWith<$Res> {
  factory _$DriverStateCopyWith(_DriverState value, $Res Function(_DriverState) _then) = __$DriverStateCopyWithImpl;
@override @useResult
$Res call({
 bool isOnline, String driverName, String driverLocation, String? driverImageUrl, bool hasReviewAlert, List<DeliveryModel> availableDeliveries
});




}
/// @nodoc
class __$DriverStateCopyWithImpl<$Res>
    implements _$DriverStateCopyWith<$Res> {
  __$DriverStateCopyWithImpl(this._self, this._then);

  final _DriverState _self;
  final $Res Function(_DriverState) _then;

/// Create a copy of DeliveryHomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOnline = null,Object? driverName = null,Object? driverLocation = null,Object? driverImageUrl = freezed,Object? hasReviewAlert = null,Object? availableDeliveries = null,}) {
  return _then(_DriverState(
isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,driverName: null == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String,driverLocation: null == driverLocation ? _self.driverLocation : driverLocation // ignore: cast_nullable_to_non_nullable
as String,driverImageUrl: freezed == driverImageUrl ? _self.driverImageUrl : driverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,hasReviewAlert: null == hasReviewAlert ? _self.hasReviewAlert : hasReviewAlert // ignore: cast_nullable_to_non_nullable
as bool,availableDeliveries: null == availableDeliveries ? _self._availableDeliveries : availableDeliveries // ignore: cast_nullable_to_non_nullable
as List<DeliveryModel>,
  ));
}


}

// dart format on
