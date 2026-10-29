// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_table_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceTableState {

 AttendanceTableStatus get status; List<MemberLogedinResponseModel> get items; int get pageNumber; int get pageSize; int get totalPages; int get totalCount; AttendancePeriod? get period; AttendanceGender? get gender; bool? get hasTrainer; String? get trainerName; String? get errorMessage;
/// Create a copy of AttendanceTableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceTableStateCopyWith<AttendanceTableState> get copyWith => _$AttendanceTableStateCopyWithImpl<AttendanceTableState>(this as AttendanceTableState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AttendanceTableState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceTableState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.pageNumber, _this.pageNumber) || other.pageNumber == _this.pageNumber)&&(identical(other.pageSize, _this.pageSize) || other.pageSize == _this.pageSize)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.gender, _this.gender) || other.gender == _this.gender)&&(identical(other.hasTrainer, _this.hasTrainer) || other.hasTrainer == _this.hasTrainer)&&(identical(other.trainerName, _this.trainerName) || other.trainerName == _this.trainerName)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as AttendanceTableState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.items),_this.pageNumber,_this.pageSize,_this.totalPages,_this.totalCount,_this.period,_this.gender,_this.hasTrainer,_this.trainerName,_this.errorMessage);
}

@override
String toString() {
  final _this = this as AttendanceTableState;
  return 'AttendanceTableState(status: ${_this.status}, items: ${_this.items}, pageNumber: ${_this.pageNumber}, pageSize: ${_this.pageSize}, totalPages: ${_this.totalPages}, totalCount: ${_this.totalCount}, period: ${_this.period}, gender: ${_this.gender}, hasTrainer: ${_this.hasTrainer}, trainerName: ${_this.trainerName}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $AttendanceTableStateCopyWith<$Res>  {
  factory $AttendanceTableStateCopyWith(AttendanceTableState value, $Res Function(AttendanceTableState) _then) = _$AttendanceTableStateCopyWithImpl;
@useResult
$Res call({
 AttendanceTableStatus status, List<MemberLogedinResponseModel> items, int pageNumber, int pageSize, int totalPages, int totalCount, AttendancePeriod? period, AttendanceGender? gender, bool? hasTrainer, String? trainerName, String? errorMessage
});




}
/// @nodoc
class _$AttendanceTableStateCopyWithImpl<$Res>
    implements $AttendanceTableStateCopyWith<$Res> {
  _$AttendanceTableStateCopyWithImpl(this._self, this._then);

  final AttendanceTableState _self;
  final $Res Function(AttendanceTableState) _then;

/// Create a copy of AttendanceTableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? pageNumber = null,Object? pageSize = null,Object? totalPages = null,Object? totalCount = null,Object? period = freezed,Object? gender = freezed,Object? hasTrainer = freezed,Object? trainerName = freezed,Object? errorMessage = freezed,}) {
  return _then(AttendanceTableState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceTableStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MemberLogedinResponseModel>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as AttendancePeriod?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as AttendanceGender?,hasTrainer: freezed == hasTrainer ? _self.hasTrainer : hasTrainer // ignore: cast_nullable_to_non_nullable
as bool?,trainerName: freezed == trainerName ? _self.trainerName : trainerName // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceTableState].
extension AttendanceTableStatePatterns on AttendanceTableState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceTableState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceTableState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceTableState value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceTableState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceTableState value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceTableState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AttendanceTableStatus status,  List<MemberLogedinResponseModel> items,  int pageNumber,  int pageSize,  int totalPages,  int totalCount,  AttendancePeriod? period,  AttendanceGender? gender,  bool? hasTrainer,  String? trainerName,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceTableState() when $default != null:
return $default(_that.status,_that.items,_that.pageNumber,_that.pageSize,_that.totalPages,_that.totalCount,_that.period,_that.gender,_that.hasTrainer,_that.trainerName,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AttendanceTableStatus status,  List<MemberLogedinResponseModel> items,  int pageNumber,  int pageSize,  int totalPages,  int totalCount,  AttendancePeriod? period,  AttendanceGender? gender,  bool? hasTrainer,  String? trainerName,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AttendanceTableState():
return $default(_that.status,_that.items,_that.pageNumber,_that.pageSize,_that.totalPages,_that.totalCount,_that.period,_that.gender,_that.hasTrainer,_that.trainerName,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AttendanceTableStatus status,  List<MemberLogedinResponseModel> items,  int pageNumber,  int pageSize,  int totalPages,  int totalCount,  AttendancePeriod? period,  AttendanceGender? gender,  bool? hasTrainer,  String? trainerName,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceTableState() when $default != null:
return $default(_that.status,_that.items,_that.pageNumber,_that.pageSize,_that.totalPages,_that.totalCount,_that.period,_that.gender,_that.hasTrainer,_that.trainerName,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AttendanceTableState extends AttendanceTableState {
  const _AttendanceTableState({this.status = AttendanceTableStatus.initial,  List<MemberLogedinResponseModel> items = const [], this.pageNumber = 1, this.pageSize = 5, this.totalPages = 1, this.totalCount = 0, this.period, this.gender, this.hasTrainer, this.trainerName, this.errorMessage}): _items = items,super._();
  

@override@JsonKey() final  AttendanceTableStatus status;
 final  List<MemberLogedinResponseModel> _items;
@override@JsonKey() List<MemberLogedinResponseModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int pageNumber;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int totalCount;
@override final  AttendancePeriod? period;
@override final  AttendanceGender? gender;
@override final  bool? hasTrainer;
@override final  String? trainerName;
@override final  String? errorMessage;

/// Create a copy of AttendanceTableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceTableStateCopyWith<_AttendanceTableState> get copyWith => __$AttendanceTableStateCopyWithImpl<_AttendanceTableState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceTableState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.period, period) || other.period == period)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.hasTrainer, hasTrainer) || other.hasTrainer == hasTrainer)&&(identical(other.trainerName, trainerName) || other.trainerName == trainerName)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),pageNumber,pageSize,totalPages,totalCount,period,gender,hasTrainer,trainerName,errorMessage);
}

@override
String toString() {
    return 'AttendanceTableState(status: $status, items: $items, pageNumber: $pageNumber, pageSize: $pageSize, totalPages: $totalPages, totalCount: $totalCount, period: $period, gender: $gender, hasTrainer: $hasTrainer, trainerName: $trainerName, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AttendanceTableStateCopyWith<$Res> implements $AttendanceTableStateCopyWith<$Res> {
  factory _$AttendanceTableStateCopyWith(_AttendanceTableState value, $Res Function(_AttendanceTableState) _then) = __$AttendanceTableStateCopyWithImpl;
@override @useResult
$Res call({
 AttendanceTableStatus status, List<MemberLogedinResponseModel> items, int pageNumber, int pageSize, int totalPages, int totalCount, AttendancePeriod? period, AttendanceGender? gender, bool? hasTrainer, String? trainerName, String? errorMessage
});




}
/// @nodoc
class __$AttendanceTableStateCopyWithImpl<$Res>
    implements _$AttendanceTableStateCopyWith<$Res> {
  __$AttendanceTableStateCopyWithImpl(this._self, this._then);

  final _AttendanceTableState _self;
  final $Res Function(_AttendanceTableState) _then;

/// Create a copy of AttendanceTableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? pageNumber = null,Object? pageSize = null,Object? totalPages = null,Object? totalCount = null,Object? period = freezed,Object? gender = freezed,Object? hasTrainer = freezed,Object? trainerName = freezed,Object? errorMessage = freezed,}) {
  return _then(_AttendanceTableState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceTableStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MemberLogedinResponseModel>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as AttendancePeriod?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as AttendanceGender?,hasTrainer: freezed == hasTrainer ? _self.hasTrainer : hasTrainer // ignore: cast_nullable_to_non_nullable
as bool?,trainerName: freezed == trainerName ? _self.trainerName : trainerName // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
