// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_show_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberShowCardModel {

 int get id; String get code; String get name; String get phone; String get gender; String? get packageName;@UtcDateTimeConverter() DateTime? get subscriptionEndDate; String? get subscriptionStatus; int? get remainingDays; int? get totalSessions; int? get remainingSessions; List<String>? get activityNames; String? get trainerName;@UtcDateTimeConverter() DateTime? get lastAttendanceTime;
/// Create a copy of MemberShowCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberShowCardModelCopyWith<MemberShowCardModel> get copyWith => _$MemberShowCardModelCopyWithImpl<MemberShowCardModel>(this as MemberShowCardModel, _$identity);

  /// Serializes this MemberShowCardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MemberShowCardModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberShowCardModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.gender, _this.gender) || other.gender == _this.gender)&&(identical(other.packageName, _this.packageName) || other.packageName == _this.packageName)&&(identical(other.subscriptionEndDate, _this.subscriptionEndDate) || other.subscriptionEndDate == _this.subscriptionEndDate)&&(identical(other.subscriptionStatus, _this.subscriptionStatus) || other.subscriptionStatus == _this.subscriptionStatus)&&(identical(other.remainingDays, _this.remainingDays) || other.remainingDays == _this.remainingDays)&&(identical(other.totalSessions, _this.totalSessions) || other.totalSessions == _this.totalSessions)&&(identical(other.remainingSessions, _this.remainingSessions) || other.remainingSessions == _this.remainingSessions)&&const DeepCollectionEquality().equals(other.activityNames, _this.activityNames)&&(identical(other.trainerName, _this.trainerName) || other.trainerName == _this.trainerName)&&(identical(other.lastAttendanceTime, _this.lastAttendanceTime) || other.lastAttendanceTime == _this.lastAttendanceTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MemberShowCardModel;
  return Object.hash(runtimeType,_this.id,_this.code,_this.name,_this.phone,_this.gender,_this.packageName,_this.subscriptionEndDate,_this.subscriptionStatus,_this.remainingDays,_this.totalSessions,_this.remainingSessions,const DeepCollectionEquality().hash(_this.activityNames),_this.trainerName,_this.lastAttendanceTime);
}

@override
String toString() {
  final _this = this as MemberShowCardModel;
  return 'MemberShowCardModel(id: ${_this.id}, code: ${_this.code}, name: ${_this.name}, phone: ${_this.phone}, gender: ${_this.gender}, packageName: ${_this.packageName}, subscriptionEndDate: ${_this.subscriptionEndDate}, subscriptionStatus: ${_this.subscriptionStatus}, remainingDays: ${_this.remainingDays}, totalSessions: ${_this.totalSessions}, remainingSessions: ${_this.remainingSessions}, activityNames: ${_this.activityNames}, trainerName: ${_this.trainerName}, lastAttendanceTime: ${_this.lastAttendanceTime})';
}


}

/// @nodoc
abstract mixin class $MemberShowCardModelCopyWith<$Res>  {
  factory $MemberShowCardModelCopyWith(MemberShowCardModel value, $Res Function(MemberShowCardModel) _then) = _$MemberShowCardModelCopyWithImpl;
@useResult
$Res call({
 int id, String code, String name, String phone, String gender, String? packageName,@UtcDateTimeConverter() DateTime? subscriptionEndDate, String? subscriptionStatus, int? remainingDays, int? totalSessions, int? remainingSessions, List<String>? activityNames, String? trainerName,@UtcDateTimeConverter() DateTime? lastAttendanceTime
});




}
/// @nodoc
class _$MemberShowCardModelCopyWithImpl<$Res>
    implements $MemberShowCardModelCopyWith<$Res> {
  _$MemberShowCardModelCopyWithImpl(this._self, this._then);

  final MemberShowCardModel _self;
  final $Res Function(MemberShowCardModel) _then;

/// Create a copy of MemberShowCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? phone = null,Object? gender = null,Object? packageName = freezed,Object? subscriptionEndDate = freezed,Object? subscriptionStatus = freezed,Object? remainingDays = freezed,Object? totalSessions = freezed,Object? remainingSessions = freezed,Object? activityNames = freezed,Object? trainerName = freezed,Object? lastAttendanceTime = freezed,}) {
  return _then(MemberShowCardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,packageName: freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,subscriptionEndDate: freezed == subscriptionEndDate ? _self.subscriptionEndDate : subscriptionEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,subscriptionStatus: freezed == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as String?,remainingDays: freezed == remainingDays ? _self.remainingDays : remainingDays // ignore: cast_nullable_to_non_nullable
as int?,totalSessions: freezed == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int?,remainingSessions: freezed == remainingSessions ? _self.remainingSessions : remainingSessions // ignore: cast_nullable_to_non_nullable
as int?,activityNames: freezed == activityNames ? _self.activityNames : activityNames // ignore: cast_nullable_to_non_nullable
as List<String>?,trainerName: freezed == trainerName ? _self.trainerName : trainerName // ignore: cast_nullable_to_non_nullable
as String?,lastAttendanceTime: freezed == lastAttendanceTime ? _self.lastAttendanceTime : lastAttendanceTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberShowCardModel].
extension MemberShowCardModelPatterns on MemberShowCardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberShowCardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberShowCardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberShowCardModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberShowCardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberShowCardModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberShowCardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String name,  String phone,  String gender,  String? packageName, @UtcDateTimeConverter()  DateTime? subscriptionEndDate,  String? subscriptionStatus,  int? remainingDays,  int? totalSessions,  int? remainingSessions,  List<String>? activityNames,  String? trainerName, @UtcDateTimeConverter()  DateTime? lastAttendanceTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberShowCardModel() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.phone,_that.gender,_that.packageName,_that.subscriptionEndDate,_that.subscriptionStatus,_that.remainingDays,_that.totalSessions,_that.remainingSessions,_that.activityNames,_that.trainerName,_that.lastAttendanceTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String name,  String phone,  String gender,  String? packageName, @UtcDateTimeConverter()  DateTime? subscriptionEndDate,  String? subscriptionStatus,  int? remainingDays,  int? totalSessions,  int? remainingSessions,  List<String>? activityNames,  String? trainerName, @UtcDateTimeConverter()  DateTime? lastAttendanceTime)  $default,) {final _that = this;
switch (_that) {
case _MemberShowCardModel():
return $default(_that.id,_that.code,_that.name,_that.phone,_that.gender,_that.packageName,_that.subscriptionEndDate,_that.subscriptionStatus,_that.remainingDays,_that.totalSessions,_that.remainingSessions,_that.activityNames,_that.trainerName,_that.lastAttendanceTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String name,  String phone,  String gender,  String? packageName, @UtcDateTimeConverter()  DateTime? subscriptionEndDate,  String? subscriptionStatus,  int? remainingDays,  int? totalSessions,  int? remainingSessions,  List<String>? activityNames,  String? trainerName, @UtcDateTimeConverter()  DateTime? lastAttendanceTime)?  $default,) {final _that = this;
switch (_that) {
case _MemberShowCardModel() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.phone,_that.gender,_that.packageName,_that.subscriptionEndDate,_that.subscriptionStatus,_that.remainingDays,_that.totalSessions,_that.remainingSessions,_that.activityNames,_that.trainerName,_that.lastAttendanceTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberShowCardModel implements MemberShowCardModel {
  const _MemberShowCardModel({required this.id, required this.code, required this.name, required this.phone, required this.gender, this.packageName, @UtcDateTimeConverter() this.subscriptionEndDate, this.subscriptionStatus, this.remainingDays, this.totalSessions, this.remainingSessions,  List<String>? activityNames, this.trainerName, @UtcDateTimeConverter() this.lastAttendanceTime}): _activityNames = activityNames;
  factory _MemberShowCardModel.fromJson(Map<String, dynamic> json) => _$MemberShowCardModelFromJson(json);

@override final  int id;
@override final  String code;
@override final  String name;
@override final  String phone;
@override final  String gender;
@override final  String? packageName;
@override@UtcDateTimeConverter() final  DateTime? subscriptionEndDate;
@override final  String? subscriptionStatus;
@override final  int? remainingDays;
@override final  int? totalSessions;
@override final  int? remainingSessions;
 final  List<String>? _activityNames;
@override List<String>? get activityNames {
  final value = _activityNames;
  if (value == null) return null;
  if (_activityNames is EqualUnmodifiableListView) return _activityNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? trainerName;
@override@UtcDateTimeConverter() final  DateTime? lastAttendanceTime;

/// Create a copy of MemberShowCardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberShowCardModelCopyWith<_MemberShowCardModel> get copyWith => __$MemberShowCardModelCopyWithImpl<_MemberShowCardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberShowCardModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberShowCardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.packageName, packageName) || other.packageName == packageName)&&(identical(other.subscriptionEndDate, subscriptionEndDate) || other.subscriptionEndDate == subscriptionEndDate)&&(identical(other.subscriptionStatus, subscriptionStatus) || other.subscriptionStatus == subscriptionStatus)&&(identical(other.remainingDays, remainingDays) || other.remainingDays == remainingDays)&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.remainingSessions, remainingSessions) || other.remainingSessions == remainingSessions)&&const DeepCollectionEquality().equals(other.activityNames, _activityNames)&&(identical(other.trainerName, trainerName) || other.trainerName == trainerName)&&(identical(other.lastAttendanceTime, lastAttendanceTime) || other.lastAttendanceTime == lastAttendanceTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,code,name,phone,gender,packageName,subscriptionEndDate,subscriptionStatus,remainingDays,totalSessions,remainingSessions,const DeepCollectionEquality().hash(_activityNames),trainerName,lastAttendanceTime);
}

@override
String toString() {
    return 'MemberShowCardModel(id: $id, code: $code, name: $name, phone: $phone, gender: $gender, packageName: $packageName, subscriptionEndDate: $subscriptionEndDate, subscriptionStatus: $subscriptionStatus, remainingDays: $remainingDays, totalSessions: $totalSessions, remainingSessions: $remainingSessions, activityNames: $activityNames, trainerName: $trainerName, lastAttendanceTime: $lastAttendanceTime)';
}


}

/// @nodoc
abstract mixin class _$MemberShowCardModelCopyWith<$Res> implements $MemberShowCardModelCopyWith<$Res> {
  factory _$MemberShowCardModelCopyWith(_MemberShowCardModel value, $Res Function(_MemberShowCardModel) _then) = __$MemberShowCardModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String name, String phone, String gender, String? packageName,@UtcDateTimeConverter() DateTime? subscriptionEndDate, String? subscriptionStatus, int? remainingDays, int? totalSessions, int? remainingSessions, List<String>? activityNames, String? trainerName,@UtcDateTimeConverter() DateTime? lastAttendanceTime
});




}
/// @nodoc
class __$MemberShowCardModelCopyWithImpl<$Res>
    implements _$MemberShowCardModelCopyWith<$Res> {
  __$MemberShowCardModelCopyWithImpl(this._self, this._then);

  final _MemberShowCardModel _self;
  final $Res Function(_MemberShowCardModel) _then;

/// Create a copy of MemberShowCardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? phone = null,Object? gender = null,Object? packageName = freezed,Object? subscriptionEndDate = freezed,Object? subscriptionStatus = freezed,Object? remainingDays = freezed,Object? totalSessions = freezed,Object? remainingSessions = freezed,Object? activityNames = freezed,Object? trainerName = freezed,Object? lastAttendanceTime = freezed,}) {
  return _then(_MemberShowCardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,packageName: freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,subscriptionEndDate: freezed == subscriptionEndDate ? _self.subscriptionEndDate : subscriptionEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,subscriptionStatus: freezed == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as String?,remainingDays: freezed == remainingDays ? _self.remainingDays : remainingDays // ignore: cast_nullable_to_non_nullable
as int?,totalSessions: freezed == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int?,remainingSessions: freezed == remainingSessions ? _self.remainingSessions : remainingSessions // ignore: cast_nullable_to_non_nullable
as int?,activityNames: freezed == activityNames ? _self._activityNames : activityNames // ignore: cast_nullable_to_non_nullable
as List<String>?,trainerName: freezed == trainerName ? _self.trainerName : trainerName // ignore: cast_nullable_to_non_nullable
as String?,lastAttendanceTime: freezed == lastAttendanceTime ? _self.lastAttendanceTime : lastAttendanceTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
