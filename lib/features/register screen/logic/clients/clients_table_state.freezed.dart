// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clients_table_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClientsTableState {

 ClientsStatus get status; List<MemberDetailsModel> get items; int get totalCount; int get totalPages; int get pageNumber; int get pageSize; String get searchTerm; String? get errorMessage;
/// Create a copy of ClientsTableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientsTableStateCopyWith<ClientsTableState> get copyWith => _$ClientsTableStateCopyWithImpl<ClientsTableState>(this as ClientsTableState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ClientsTableState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientsTableState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.pageNumber, _this.pageNumber) || other.pageNumber == _this.pageNumber)&&(identical(other.pageSize, _this.pageSize) || other.pageSize == _this.pageSize)&&(identical(other.searchTerm, _this.searchTerm) || other.searchTerm == _this.searchTerm)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as ClientsTableState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.items),_this.totalCount,_this.totalPages,_this.pageNumber,_this.pageSize,_this.searchTerm,_this.errorMessage);
}

@override
String toString() {
  final _this = this as ClientsTableState;
  return 'ClientsTableState(status: ${_this.status}, items: ${_this.items}, totalCount: ${_this.totalCount}, totalPages: ${_this.totalPages}, pageNumber: ${_this.pageNumber}, pageSize: ${_this.pageSize}, searchTerm: ${_this.searchTerm}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $ClientsTableStateCopyWith<$Res>  {
  factory $ClientsTableStateCopyWith(ClientsTableState value, $Res Function(ClientsTableState) _then) = _$ClientsTableStateCopyWithImpl;
@useResult
$Res call({
 ClientsStatus status, List<MemberDetailsModel> items, int totalCount, int totalPages, int pageNumber, int pageSize, String searchTerm, String? errorMessage
});




}
/// @nodoc
class _$ClientsTableStateCopyWithImpl<$Res>
    implements $ClientsTableStateCopyWith<$Res> {
  _$ClientsTableStateCopyWithImpl(this._self, this._then);

  final ClientsTableState _self;
  final $Res Function(ClientsTableState) _then;

/// Create a copy of ClientsTableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? totalCount = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,Object? searchTerm = null,Object? errorMessage = freezed,}) {
  return _then(ClientsTableState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ClientsStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MemberDetailsModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,searchTerm: null == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientsTableState].
extension ClientsTableStatePatterns on ClientsTableState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientsTableState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientsTableState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientsTableState value)  $default,){
final _that = this;
switch (_that) {
case _ClientsTableState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientsTableState value)?  $default,){
final _that = this;
switch (_that) {
case _ClientsTableState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ClientsStatus status,  List<MemberDetailsModel> items,  int totalCount,  int totalPages,  int pageNumber,  int pageSize,  String searchTerm,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientsTableState() when $default != null:
return $default(_that.status,_that.items,_that.totalCount,_that.totalPages,_that.pageNumber,_that.pageSize,_that.searchTerm,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ClientsStatus status,  List<MemberDetailsModel> items,  int totalCount,  int totalPages,  int pageNumber,  int pageSize,  String searchTerm,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ClientsTableState():
return $default(_that.status,_that.items,_that.totalCount,_that.totalPages,_that.pageNumber,_that.pageSize,_that.searchTerm,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ClientsStatus status,  List<MemberDetailsModel> items,  int totalCount,  int totalPages,  int pageNumber,  int pageSize,  String searchTerm,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ClientsTableState() when $default != null:
return $default(_that.status,_that.items,_that.totalCount,_that.totalPages,_that.pageNumber,_that.pageSize,_that.searchTerm,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ClientsTableState implements ClientsTableState {
  const _ClientsTableState({this.status = ClientsStatus.initial,  List<MemberDetailsModel> items = const <MemberDetailsModel>[], this.totalCount = 0, this.totalPages = 0, this.pageNumber = 1, this.pageSize = 10, this.searchTerm = '', this.errorMessage}): _items = items;
  

@override@JsonKey() final  ClientsStatus status;
 final  List<MemberDetailsModel> _items;
@override@JsonKey() List<MemberDetailsModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int pageNumber;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  String searchTerm;
@override final  String? errorMessage;

/// Create a copy of ClientsTableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientsTableStateCopyWith<_ClientsTableState> get copyWith => __$ClientsTableStateCopyWithImpl<_ClientsTableState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientsTableState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),totalCount,totalPages,pageNumber,pageSize,searchTerm,errorMessage);
}

@override
String toString() {
    return 'ClientsTableState(status: $status, items: $items, totalCount: $totalCount, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize, searchTerm: $searchTerm, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ClientsTableStateCopyWith<$Res> implements $ClientsTableStateCopyWith<$Res> {
  factory _$ClientsTableStateCopyWith(_ClientsTableState value, $Res Function(_ClientsTableState) _then) = __$ClientsTableStateCopyWithImpl;
@override @useResult
$Res call({
 ClientsStatus status, List<MemberDetailsModel> items, int totalCount, int totalPages, int pageNumber, int pageSize, String searchTerm, String? errorMessage
});




}
/// @nodoc
class __$ClientsTableStateCopyWithImpl<$Res>
    implements _$ClientsTableStateCopyWith<$Res> {
  __$ClientsTableStateCopyWithImpl(this._self, this._then);

  final _ClientsTableState _self;
  final $Res Function(_ClientsTableState) _then;

/// Create a copy of ClientsTableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? totalCount = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,Object? searchTerm = null,Object? errorMessage = freezed,}) {
  return _then(_ClientsTableState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ClientsStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MemberDetailsModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,searchTerm: null == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
