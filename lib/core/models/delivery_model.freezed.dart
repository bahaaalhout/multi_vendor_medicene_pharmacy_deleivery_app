// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryModel {

 String get id; OrderModel get order; DeliveryStatus get status; double get distanceKm; double get timeMinutes; double get price; double get rating; String? get customerOtp; String? get proofImageUrl; String? get statusMessage;
/// Create a copy of DeliveryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryModelCopyWith<DeliveryModel> get copyWith => _$DeliveryModelCopyWithImpl<DeliveryModel>(this as DeliveryModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.status, status) || other.status == status)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.timeMinutes, timeMinutes) || other.timeMinutes == timeMinutes)&&(identical(other.price, price) || other.price == price)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.customerOtp, customerOtp) || other.customerOtp == customerOtp)&&(identical(other.proofImageUrl, proofImageUrl) || other.proofImageUrl == proofImageUrl)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}


@override
int get hashCode => Object.hash(runtimeType,id,order,status,distanceKm,timeMinutes,price,rating,customerOtp,proofImageUrl,statusMessage);

@override
String toString() {
  return 'DeliveryModel(id: $id, order: $order, status: $status, distanceKm: $distanceKm, timeMinutes: $timeMinutes, price: $price, rating: $rating, customerOtp: $customerOtp, proofImageUrl: $proofImageUrl, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class $DeliveryModelCopyWith<$Res>  {
  factory $DeliveryModelCopyWith(DeliveryModel value, $Res Function(DeliveryModel) _then) = _$DeliveryModelCopyWithImpl;
@useResult
$Res call({
 String id, OrderModel order, DeliveryStatus status, double distanceKm, double timeMinutes, double price, double rating, String? customerOtp, String? proofImageUrl, String? statusMessage
});




}
/// @nodoc
class _$DeliveryModelCopyWithImpl<$Res>
    implements $DeliveryModelCopyWith<$Res> {
  _$DeliveryModelCopyWithImpl(this._self, this._then);

  final DeliveryModel _self;
  final $Res Function(DeliveryModel) _then;

/// Create a copy of DeliveryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? order = null,Object? status = null,Object? distanceKm = null,Object? timeMinutes = null,Object? price = null,Object? rating = null,Object? customerOtp = freezed,Object? proofImageUrl = freezed,Object? statusMessage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,timeMinutes: null == timeMinutes ? _self.timeMinutes : timeMinutes // ignore: cast_nullable_to_non_nullable
as double,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,customerOtp: freezed == customerOtp ? _self.customerOtp : customerOtp // ignore: cast_nullable_to_non_nullable
as String?,proofImageUrl: freezed == proofImageUrl ? _self.proofImageUrl : proofImageUrl // ignore: cast_nullable_to_non_nullable
as String?,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryModel].
extension DeliveryModelPatterns on DeliveryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryModel value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryModel value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  OrderModel order,  DeliveryStatus status,  double distanceKm,  double timeMinutes,  double price,  double rating,  String? customerOtp,  String? proofImageUrl,  String? statusMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryModel() when $default != null:
return $default(_that.id,_that.order,_that.status,_that.distanceKm,_that.timeMinutes,_that.price,_that.rating,_that.customerOtp,_that.proofImageUrl,_that.statusMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  OrderModel order,  DeliveryStatus status,  double distanceKm,  double timeMinutes,  double price,  double rating,  String? customerOtp,  String? proofImageUrl,  String? statusMessage)  $default,) {final _that = this;
switch (_that) {
case _DeliveryModel():
return $default(_that.id,_that.order,_that.status,_that.distanceKm,_that.timeMinutes,_that.price,_that.rating,_that.customerOtp,_that.proofImageUrl,_that.statusMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  OrderModel order,  DeliveryStatus status,  double distanceKm,  double timeMinutes,  double price,  double rating,  String? customerOtp,  String? proofImageUrl,  String? statusMessage)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryModel() when $default != null:
return $default(_that.id,_that.order,_that.status,_that.distanceKm,_that.timeMinutes,_that.price,_that.rating,_that.customerOtp,_that.proofImageUrl,_that.statusMessage);case _:
  return null;

}
}

}

/// @nodoc


class _DeliveryModel implements DeliveryModel {
  const _DeliveryModel({required this.id, required this.order, required this.status, required this.distanceKm, required this.timeMinutes, required this.price, required this.rating, this.customerOtp, this.proofImageUrl, this.statusMessage});
  

@override final  String id;
@override final  OrderModel order;
@override final  DeliveryStatus status;
@override final  double distanceKm;
@override final  double timeMinutes;
@override final  double price;
@override final  double rating;
@override final  String? customerOtp;
@override final  String? proofImageUrl;
@override final  String? statusMessage;

/// Create a copy of DeliveryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryModelCopyWith<_DeliveryModel> get copyWith => __$DeliveryModelCopyWithImpl<_DeliveryModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.status, status) || other.status == status)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.timeMinutes, timeMinutes) || other.timeMinutes == timeMinutes)&&(identical(other.price, price) || other.price == price)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.customerOtp, customerOtp) || other.customerOtp == customerOtp)&&(identical(other.proofImageUrl, proofImageUrl) || other.proofImageUrl == proofImageUrl)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}


@override
int get hashCode => Object.hash(runtimeType,id,order,status,distanceKm,timeMinutes,price,rating,customerOtp,proofImageUrl,statusMessage);

@override
String toString() {
  return 'DeliveryModel(id: $id, order: $order, status: $status, distanceKm: $distanceKm, timeMinutes: $timeMinutes, price: $price, rating: $rating, customerOtp: $customerOtp, proofImageUrl: $proofImageUrl, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class _$DeliveryModelCopyWith<$Res> implements $DeliveryModelCopyWith<$Res> {
  factory _$DeliveryModelCopyWith(_DeliveryModel value, $Res Function(_DeliveryModel) _then) = __$DeliveryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, OrderModel order, DeliveryStatus status, double distanceKm, double timeMinutes, double price, double rating, String? customerOtp, String? proofImageUrl, String? statusMessage
});




}
/// @nodoc
class __$DeliveryModelCopyWithImpl<$Res>
    implements _$DeliveryModelCopyWith<$Res> {
  __$DeliveryModelCopyWithImpl(this._self, this._then);

  final _DeliveryModel _self;
  final $Res Function(_DeliveryModel) _then;

/// Create a copy of DeliveryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? order = null,Object? status = null,Object? distanceKm = null,Object? timeMinutes = null,Object? price = null,Object? rating = null,Object? customerOtp = freezed,Object? proofImageUrl = freezed,Object? statusMessage = freezed,}) {
  return _then(_DeliveryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,timeMinutes: null == timeMinutes ? _self.timeMinutes : timeMinutes // ignore: cast_nullable_to_non_nullable
as double,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,customerOtp: freezed == customerOtp ? _self.customerOtp : customerOtp // ignore: cast_nullable_to_non_nullable
as String?,proofImageUrl: freezed == proofImageUrl ? _self.proofImageUrl : proofImageUrl // ignore: cast_nullable_to_non_nullable
as String?,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
