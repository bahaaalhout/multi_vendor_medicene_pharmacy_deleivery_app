// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pharmacy_order_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PharmacyOrderDetailsState {

 String get pharmacyName; String get searchQuery; OrderStatusFilter get selectedStatusFilter; List<OrderModel> get orders; List<OrderModel> get filteredOrders;
/// Create a copy of PharmacyOrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PharmacyOrderDetailsStateCopyWith<PharmacyOrderDetailsState> get copyWith => _$PharmacyOrderDetailsStateCopyWithImpl<PharmacyOrderDetailsState>(this as PharmacyOrderDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PharmacyOrderDetailsState&&(identical(other.pharmacyName, pharmacyName) || other.pharmacyName == pharmacyName)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedStatusFilter, selectedStatusFilter) || other.selectedStatusFilter == selectedStatusFilter)&&const DeepCollectionEquality().equals(other.orders, orders)&&const DeepCollectionEquality().equals(other.filteredOrders, filteredOrders));
}


@override
int get hashCode => Object.hash(runtimeType,pharmacyName,searchQuery,selectedStatusFilter,const DeepCollectionEquality().hash(orders),const DeepCollectionEquality().hash(filteredOrders));

@override
String toString() {
  return 'PharmacyOrderDetailsState(pharmacyName: $pharmacyName, searchQuery: $searchQuery, selectedStatusFilter: $selectedStatusFilter, orders: $orders, filteredOrders: $filteredOrders)';
}


}

/// @nodoc
abstract mixin class $PharmacyOrderDetailsStateCopyWith<$Res>  {
  factory $PharmacyOrderDetailsStateCopyWith(PharmacyOrderDetailsState value, $Res Function(PharmacyOrderDetailsState) _then) = _$PharmacyOrderDetailsStateCopyWithImpl;
@useResult
$Res call({
 String pharmacyName, String searchQuery, OrderStatusFilter selectedStatusFilter, List<OrderModel> orders, List<OrderModel> filteredOrders
});




}
/// @nodoc
class _$PharmacyOrderDetailsStateCopyWithImpl<$Res>
    implements $PharmacyOrderDetailsStateCopyWith<$Res> {
  _$PharmacyOrderDetailsStateCopyWithImpl(this._self, this._then);

  final PharmacyOrderDetailsState _self;
  final $Res Function(PharmacyOrderDetailsState) _then;

/// Create a copy of PharmacyOrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pharmacyName = null,Object? searchQuery = null,Object? selectedStatusFilter = null,Object? orders = null,Object? filteredOrders = null,}) {
  return _then(_self.copyWith(
pharmacyName: null == pharmacyName ? _self.pharmacyName : pharmacyName // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedStatusFilter: null == selectedStatusFilter ? _self.selectedStatusFilter : selectedStatusFilter // ignore: cast_nullable_to_non_nullable
as OrderStatusFilter,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderModel>,filteredOrders: null == filteredOrders ? _self.filteredOrders : filteredOrders // ignore: cast_nullable_to_non_nullable
as List<OrderModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [PharmacyOrderDetailsState].
extension PharmacyOrderDetailsStatePatterns on PharmacyOrderDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PharmacyOrderDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PharmacyOrderDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PharmacyOrderDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _PharmacyOrderDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PharmacyOrderDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _PharmacyOrderDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pharmacyName,  String searchQuery,  OrderStatusFilter selectedStatusFilter,  List<OrderModel> orders,  List<OrderModel> filteredOrders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PharmacyOrderDetailsState() when $default != null:
return $default(_that.pharmacyName,_that.searchQuery,_that.selectedStatusFilter,_that.orders,_that.filteredOrders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pharmacyName,  String searchQuery,  OrderStatusFilter selectedStatusFilter,  List<OrderModel> orders,  List<OrderModel> filteredOrders)  $default,) {final _that = this;
switch (_that) {
case _PharmacyOrderDetailsState():
return $default(_that.pharmacyName,_that.searchQuery,_that.selectedStatusFilter,_that.orders,_that.filteredOrders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pharmacyName,  String searchQuery,  OrderStatusFilter selectedStatusFilter,  List<OrderModel> orders,  List<OrderModel> filteredOrders)?  $default,) {final _that = this;
switch (_that) {
case _PharmacyOrderDetailsState() when $default != null:
return $default(_that.pharmacyName,_that.searchQuery,_that.selectedStatusFilter,_that.orders,_that.filteredOrders);case _:
  return null;

}
}

}

/// @nodoc


class _PharmacyOrderDetailsState implements PharmacyOrderDetailsState {
  const _PharmacyOrderDetailsState({this.pharmacyName = '', this.searchQuery = '', this.selectedStatusFilter = OrderStatusFilter.all, final  List<OrderModel> orders = const <OrderModel>[], final  List<OrderModel> filteredOrders = const <OrderModel>[]}): _orders = orders,_filteredOrders = filteredOrders;
  

@override@JsonKey() final  String pharmacyName;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  OrderStatusFilter selectedStatusFilter;
 final  List<OrderModel> _orders;
@override@JsonKey() List<OrderModel> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

 final  List<OrderModel> _filteredOrders;
@override@JsonKey() List<OrderModel> get filteredOrders {
  if (_filteredOrders is EqualUnmodifiableListView) return _filteredOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredOrders);
}


/// Create a copy of PharmacyOrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PharmacyOrderDetailsStateCopyWith<_PharmacyOrderDetailsState> get copyWith => __$PharmacyOrderDetailsStateCopyWithImpl<_PharmacyOrderDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PharmacyOrderDetailsState&&(identical(other.pharmacyName, pharmacyName) || other.pharmacyName == pharmacyName)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedStatusFilter, selectedStatusFilter) || other.selectedStatusFilter == selectedStatusFilter)&&const DeepCollectionEquality().equals(other._orders, _orders)&&const DeepCollectionEquality().equals(other._filteredOrders, _filteredOrders));
}


@override
int get hashCode => Object.hash(runtimeType,pharmacyName,searchQuery,selectedStatusFilter,const DeepCollectionEquality().hash(_orders),const DeepCollectionEquality().hash(_filteredOrders));

@override
String toString() {
  return 'PharmacyOrderDetailsState(pharmacyName: $pharmacyName, searchQuery: $searchQuery, selectedStatusFilter: $selectedStatusFilter, orders: $orders, filteredOrders: $filteredOrders)';
}


}

/// @nodoc
abstract mixin class _$PharmacyOrderDetailsStateCopyWith<$Res> implements $PharmacyOrderDetailsStateCopyWith<$Res> {
  factory _$PharmacyOrderDetailsStateCopyWith(_PharmacyOrderDetailsState value, $Res Function(_PharmacyOrderDetailsState) _then) = __$PharmacyOrderDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 String pharmacyName, String searchQuery, OrderStatusFilter selectedStatusFilter, List<OrderModel> orders, List<OrderModel> filteredOrders
});




}
/// @nodoc
class __$PharmacyOrderDetailsStateCopyWithImpl<$Res>
    implements _$PharmacyOrderDetailsStateCopyWith<$Res> {
  __$PharmacyOrderDetailsStateCopyWithImpl(this._self, this._then);

  final _PharmacyOrderDetailsState _self;
  final $Res Function(_PharmacyOrderDetailsState) _then;

/// Create a copy of PharmacyOrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pharmacyName = null,Object? searchQuery = null,Object? selectedStatusFilter = null,Object? orders = null,Object? filteredOrders = null,}) {
  return _then(_PharmacyOrderDetailsState(
pharmacyName: null == pharmacyName ? _self.pharmacyName : pharmacyName // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedStatusFilter: null == selectedStatusFilter ? _self.selectedStatusFilter : selectedStatusFilter // ignore: cast_nullable_to_non_nullable
as OrderStatusFilter,orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderModel>,filteredOrders: null == filteredOrders ? _self._filteredOrders : filteredOrders // ignore: cast_nullable_to_non_nullable
as List<OrderModel>,
  ));
}


}

// dart format on
