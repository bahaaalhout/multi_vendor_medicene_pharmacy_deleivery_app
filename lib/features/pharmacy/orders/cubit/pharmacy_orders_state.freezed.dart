// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pharmacy_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PharmacyOrdersState {

 String get pharmacyName; String get searchQuery; OrderStatusFilter get selectedStatusFilter; List<OrderModel> get orders; List<OrderModel> get filteredOrders;
/// Create a copy of PharmacyOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PharmacyOrdersStateCopyWith<PharmacyOrdersState> get copyWith => _$PharmacyOrdersStateCopyWithImpl<PharmacyOrdersState>(this as PharmacyOrdersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PharmacyOrdersState&&(identical(other.pharmacyName, pharmacyName) || other.pharmacyName == pharmacyName)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedStatusFilter, selectedStatusFilter) || other.selectedStatusFilter == selectedStatusFilter)&&const DeepCollectionEquality().equals(other.orders, orders)&&const DeepCollectionEquality().equals(other.filteredOrders, filteredOrders));
}


@override
int get hashCode => Object.hash(runtimeType,pharmacyName,searchQuery,selectedStatusFilter,const DeepCollectionEquality().hash(orders),const DeepCollectionEquality().hash(filteredOrders));

@override
String toString() {
  return 'PharmacyOrdersState(pharmacyName: $pharmacyName, searchQuery: $searchQuery, selectedStatusFilter: $selectedStatusFilter, orders: $orders, filteredOrders: $filteredOrders)';
}


}

/// @nodoc
abstract mixin class $PharmacyOrdersStateCopyWith<$Res>  {
  factory $PharmacyOrdersStateCopyWith(PharmacyOrdersState value, $Res Function(PharmacyOrdersState) _then) = _$PharmacyOrdersStateCopyWithImpl;
@useResult
$Res call({
 String pharmacyName, String searchQuery, OrderStatusFilter selectedStatusFilter, List<OrderModel> orders, List<OrderModel> filteredOrders
});




}
/// @nodoc
class _$PharmacyOrdersStateCopyWithImpl<$Res>
    implements $PharmacyOrdersStateCopyWith<$Res> {
  _$PharmacyOrdersStateCopyWithImpl(this._self, this._then);

  final PharmacyOrdersState _self;
  final $Res Function(PharmacyOrdersState) _then;

/// Create a copy of PharmacyOrdersState
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


/// Adds pattern-matching-related methods to [PharmacyOrdersState].
extension PharmacyOrdersStatePatterns on PharmacyOrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PharmacyOrdersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PharmacyOrdersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PharmacyOrdersState value)  $default,){
final _that = this;
switch (_that) {
case _PharmacyOrdersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PharmacyOrdersState value)?  $default,){
final _that = this;
switch (_that) {
case _PharmacyOrdersState() when $default != null:
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
case _PharmacyOrdersState() when $default != null:
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
case _PharmacyOrdersState():
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
case _PharmacyOrdersState() when $default != null:
return $default(_that.pharmacyName,_that.searchQuery,_that.selectedStatusFilter,_that.orders,_that.filteredOrders);case _:
  return null;

}
}

}

/// @nodoc


class _PharmacyOrdersState implements PharmacyOrdersState {
  const _PharmacyOrdersState({this.pharmacyName = 'Pharmcy Name', this.searchQuery = '', this.selectedStatusFilter = OrderStatusFilter.all, final  List<OrderModel> orders = const <OrderModel>[], final  List<OrderModel> filteredOrders = const <OrderModel>[]}): _orders = orders,_filteredOrders = filteredOrders;
  

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


/// Create a copy of PharmacyOrdersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PharmacyOrdersStateCopyWith<_PharmacyOrdersState> get copyWith => __$PharmacyOrdersStateCopyWithImpl<_PharmacyOrdersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PharmacyOrdersState&&(identical(other.pharmacyName, pharmacyName) || other.pharmacyName == pharmacyName)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedStatusFilter, selectedStatusFilter) || other.selectedStatusFilter == selectedStatusFilter)&&const DeepCollectionEquality().equals(other._orders, _orders)&&const DeepCollectionEquality().equals(other._filteredOrders, _filteredOrders));
}


@override
int get hashCode => Object.hash(runtimeType,pharmacyName,searchQuery,selectedStatusFilter,const DeepCollectionEquality().hash(_orders),const DeepCollectionEquality().hash(_filteredOrders));

@override
String toString() {
  return 'PharmacyOrdersState(pharmacyName: $pharmacyName, searchQuery: $searchQuery, selectedStatusFilter: $selectedStatusFilter, orders: $orders, filteredOrders: $filteredOrders)';
}


}

/// @nodoc
abstract mixin class _$PharmacyOrdersStateCopyWith<$Res> implements $PharmacyOrdersStateCopyWith<$Res> {
  factory _$PharmacyOrdersStateCopyWith(_PharmacyOrdersState value, $Res Function(_PharmacyOrdersState) _then) = __$PharmacyOrdersStateCopyWithImpl;
@override @useResult
$Res call({
 String pharmacyName, String searchQuery, OrderStatusFilter selectedStatusFilter, List<OrderModel> orders, List<OrderModel> filteredOrders
});




}
/// @nodoc
class __$PharmacyOrdersStateCopyWithImpl<$Res>
    implements _$PharmacyOrdersStateCopyWith<$Res> {
  __$PharmacyOrdersStateCopyWithImpl(this._self, this._then);

  final _PharmacyOrdersState _self;
  final $Res Function(_PharmacyOrdersState) _then;

/// Create a copy of PharmacyOrdersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pharmacyName = null,Object? searchQuery = null,Object? selectedStatusFilter = null,Object? orders = null,Object? filteredOrders = null,}) {
  return _then(_PharmacyOrdersState(
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
