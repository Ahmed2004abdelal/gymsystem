// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberInfoState {

 InfoStatus get memberStatus; InfoStatus get subscriptionsStatus; InfoStatus get attendanceStatus; InfoStatus get activitiesStatus; InfoStatus get updateStatus; InfoStatus get deleteStatus; MemberShowCardModel? get member; List<GymSubscriptionResponseModel> get subscriptions; List<MemberLogedinResponseModel> get attendance;/// الأنشطة المشترك فيها العضو (memberActivitiesAttendance).
 List<MemberActivityLogedinModel> get activities; String? get memberError; String? get subscriptionsError; String? get attendanceError; String? get activitiesError; String? get actionError;
/// Create a copy of MemberInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberInfoStateCopyWith<MemberInfoState> get copyWith => _$MemberInfoStateCopyWithImpl<MemberInfoState>(this as MemberInfoState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MemberInfoState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberInfoState&&(identical(other.memberStatus, _this.memberStatus) || other.memberStatus == _this.memberStatus)&&(identical(other.subscriptionsStatus, _this.subscriptionsStatus) || other.subscriptionsStatus == _this.subscriptionsStatus)&&(identical(other.attendanceStatus, _this.attendanceStatus) || other.attendanceStatus == _this.attendanceStatus)&&(identical(other.activitiesStatus, _this.activitiesStatus) || other.activitiesStatus == _this.activitiesStatus)&&(identical(other.updateStatus, _this.updateStatus) || other.updateStatus == _this.updateStatus)&&(identical(other.deleteStatus, _this.deleteStatus) || other.deleteStatus == _this.deleteStatus)&&(identical(other.member, _this.member) || other.member == _this.member)&&const DeepCollectionEquality().equals(other.subscriptions, _this.subscriptions)&&const DeepCollectionEquality().equals(other.attendance, _this.attendance)&&const DeepCollectionEquality().equals(other.activities, _this.activities)&&(identical(other.memberError, _this.memberError) || other.memberError == _this.memberError)&&(identical(other.subscriptionsError, _this.subscriptionsError) || other.subscriptionsError == _this.subscriptionsError)&&(identical(other.attendanceError, _this.attendanceError) || other.attendanceError == _this.attendanceError)&&(identical(other.activitiesError, _this.activitiesError) || other.activitiesError == _this.activitiesError)&&(identical(other.actionError, _this.actionError) || other.actionError == _this.actionError));
}


@override
int get hashCode {
  final _this = this as MemberInfoState;
  return Object.hash(runtimeType,_this.memberStatus,_this.subscriptionsStatus,_this.attendanceStatus,_this.activitiesStatus,_this.updateStatus,_this.deleteStatus,_this.member,const DeepCollectionEquality().hash(_this.subscriptions),const DeepCollectionEquality().hash(_this.attendance),const DeepCollectionEquality().hash(_this.activities),_this.memberError,_this.subscriptionsError,_this.attendanceError,_this.activitiesError,_this.actionError);
}

@override
String toString() {
  final _this = this as MemberInfoState;
  return 'MemberInfoState(memberStatus: ${_this.memberStatus}, subscriptionsStatus: ${_this.subscriptionsStatus}, attendanceStatus: ${_this.attendanceStatus}, activitiesStatus: ${_this.activitiesStatus}, updateStatus: ${_this.updateStatus}, deleteStatus: ${_this.deleteStatus}, member: ${_this.member}, subscriptions: ${_this.subscriptions}, attendance: ${_this.attendance}, activities: ${_this.activities}, memberError: ${_this.memberError}, subscriptionsError: ${_this.subscriptionsError}, attendanceError: ${_this.attendanceError}, activitiesError: ${_this.activitiesError}, actionError: ${_this.actionError})';
}


}

/// @nodoc
abstract mixin class $MemberInfoStateCopyWith<$Res>  {
  factory $MemberInfoStateCopyWith(MemberInfoState value, $Res Function(MemberInfoState) _then) = _$MemberInfoStateCopyWithImpl;
@useResult
$Res call({
 InfoStatus memberStatus, InfoStatus subscriptionsStatus, InfoStatus attendanceStatus, InfoStatus activitiesStatus, InfoStatus updateStatus, InfoStatus deleteStatus, MemberShowCardModel? member, List<GymSubscriptionResponseModel> subscriptions, List<MemberLogedinResponseModel> attendance, List<MemberActivityLogedinModel> activities, String? memberError, String? subscriptionsError, String? attendanceError, String? activitiesError, String? actionError
});


$MemberShowCardModelCopyWith<$Res>? get member;

}
/// @nodoc
class _$MemberInfoStateCopyWithImpl<$Res>
    implements $MemberInfoStateCopyWith<$Res> {
  _$MemberInfoStateCopyWithImpl(this._self, this._then);

  final MemberInfoState _self;
  final $Res Function(MemberInfoState) _then;

/// Create a copy of MemberInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberStatus = null,Object? subscriptionsStatus = null,Object? attendanceStatus = null,Object? activitiesStatus = null,Object? updateStatus = null,Object? deleteStatus = null,Object? member = freezed,Object? subscriptions = null,Object? attendance = null,Object? activities = null,Object? memberError = freezed,Object? subscriptionsError = freezed,Object? attendanceError = freezed,Object? activitiesError = freezed,Object? actionError = freezed,}) {
  return _then(MemberInfoState(
memberStatus: null == memberStatus ? _self.memberStatus : memberStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,subscriptionsStatus: null == subscriptionsStatus ? _self.subscriptionsStatus : subscriptionsStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,attendanceStatus: null == attendanceStatus ? _self.attendanceStatus : attendanceStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,activitiesStatus: null == activitiesStatus ? _self.activitiesStatus : activitiesStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,updateStatus: null == updateStatus ? _self.updateStatus : updateStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,member: freezed == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberShowCardModel?,subscriptions: null == subscriptions ? _self.subscriptions : subscriptions // ignore: cast_nullable_to_non_nullable
as List<GymSubscriptionResponseModel>,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as List<MemberLogedinResponseModel>,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<MemberActivityLogedinModel>,memberError: freezed == memberError ? _self.memberError : memberError // ignore: cast_nullable_to_non_nullable
as String?,subscriptionsError: freezed == subscriptionsError ? _self.subscriptionsError : subscriptionsError // ignore: cast_nullable_to_non_nullable
as String?,attendanceError: freezed == attendanceError ? _self.attendanceError : attendanceError // ignore: cast_nullable_to_non_nullable
as String?,activitiesError: freezed == activitiesError ? _self.activitiesError : activitiesError // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MemberInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberShowCardModelCopyWith<$Res>? get member {
    if (_self.member == null) {
    return null;
  }

  return $MemberShowCardModelCopyWith<$Res>(_self.member!, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// Adds pattern-matching-related methods to [MemberInfoState].
extension MemberInfoStatePatterns on MemberInfoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberInfoState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberInfoState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberInfoState value)  $default,){
final _that = this;
switch (_that) {
case _MemberInfoState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberInfoState value)?  $default,){
final _that = this;
switch (_that) {
case _MemberInfoState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InfoStatus memberStatus,  InfoStatus subscriptionsStatus,  InfoStatus attendanceStatus,  InfoStatus activitiesStatus,  InfoStatus updateStatus,  InfoStatus deleteStatus,  MemberShowCardModel? member,  List<GymSubscriptionResponseModel> subscriptions,  List<MemberLogedinResponseModel> attendance,  List<MemberActivityLogedinModel> activities,  String? memberError,  String? subscriptionsError,  String? attendanceError,  String? activitiesError,  String? actionError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberInfoState() when $default != null:
return $default(_that.memberStatus,_that.subscriptionsStatus,_that.attendanceStatus,_that.activitiesStatus,_that.updateStatus,_that.deleteStatus,_that.member,_that.subscriptions,_that.attendance,_that.activities,_that.memberError,_that.subscriptionsError,_that.attendanceError,_that.activitiesError,_that.actionError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InfoStatus memberStatus,  InfoStatus subscriptionsStatus,  InfoStatus attendanceStatus,  InfoStatus activitiesStatus,  InfoStatus updateStatus,  InfoStatus deleteStatus,  MemberShowCardModel? member,  List<GymSubscriptionResponseModel> subscriptions,  List<MemberLogedinResponseModel> attendance,  List<MemberActivityLogedinModel> activities,  String? memberError,  String? subscriptionsError,  String? attendanceError,  String? activitiesError,  String? actionError)  $default,) {final _that = this;
switch (_that) {
case _MemberInfoState():
return $default(_that.memberStatus,_that.subscriptionsStatus,_that.attendanceStatus,_that.activitiesStatus,_that.updateStatus,_that.deleteStatus,_that.member,_that.subscriptions,_that.attendance,_that.activities,_that.memberError,_that.subscriptionsError,_that.attendanceError,_that.activitiesError,_that.actionError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InfoStatus memberStatus,  InfoStatus subscriptionsStatus,  InfoStatus attendanceStatus,  InfoStatus activitiesStatus,  InfoStatus updateStatus,  InfoStatus deleteStatus,  MemberShowCardModel? member,  List<GymSubscriptionResponseModel> subscriptions,  List<MemberLogedinResponseModel> attendance,  List<MemberActivityLogedinModel> activities,  String? memberError,  String? subscriptionsError,  String? attendanceError,  String? activitiesError,  String? actionError)?  $default,) {final _that = this;
switch (_that) {
case _MemberInfoState() when $default != null:
return $default(_that.memberStatus,_that.subscriptionsStatus,_that.attendanceStatus,_that.activitiesStatus,_that.updateStatus,_that.deleteStatus,_that.member,_that.subscriptions,_that.attendance,_that.activities,_that.memberError,_that.subscriptionsError,_that.attendanceError,_that.activitiesError,_that.actionError);case _:
  return null;

}
}

}

/// @nodoc


class _MemberInfoState implements MemberInfoState {
  const _MemberInfoState({this.memberStatus = InfoStatus.initial, this.subscriptionsStatus = InfoStatus.initial, this.attendanceStatus = InfoStatus.initial, this.activitiesStatus = InfoStatus.initial, this.updateStatus = InfoStatus.initial, this.deleteStatus = InfoStatus.initial, this.member,  List<GymSubscriptionResponseModel> subscriptions = const <GymSubscriptionResponseModel>[],  List<MemberLogedinResponseModel> attendance = const <MemberLogedinResponseModel>[],  List<MemberActivityLogedinModel> activities = const <MemberActivityLogedinModel>[], this.memberError, this.subscriptionsError, this.attendanceError, this.activitiesError, this.actionError}): _subscriptions = subscriptions,_attendance = attendance,_activities = activities;
  

@override@JsonKey() final  InfoStatus memberStatus;
@override@JsonKey() final  InfoStatus subscriptionsStatus;
@override@JsonKey() final  InfoStatus attendanceStatus;
@override@JsonKey() final  InfoStatus activitiesStatus;
@override@JsonKey() final  InfoStatus updateStatus;
@override@JsonKey() final  InfoStatus deleteStatus;
@override final  MemberShowCardModel? member;
 final  List<GymSubscriptionResponseModel> _subscriptions;
@override@JsonKey() List<GymSubscriptionResponseModel> get subscriptions {
  if (_subscriptions is EqualUnmodifiableListView) return _subscriptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subscriptions);
}

 final  List<MemberLogedinResponseModel> _attendance;
@override@JsonKey() List<MemberLogedinResponseModel> get attendance {
  if (_attendance is EqualUnmodifiableListView) return _attendance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attendance);
}

/// الأنشطة المشترك فيها العضو (memberActivitiesAttendance).
 final  List<MemberActivityLogedinModel> _activities;
/// الأنشطة المشترك فيها العضو (memberActivitiesAttendance).
@override@JsonKey() List<MemberActivityLogedinModel> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}

@override final  String? memberError;
@override final  String? subscriptionsError;
@override final  String? attendanceError;
@override final  String? activitiesError;
@override final  String? actionError;

/// Create a copy of MemberInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberInfoStateCopyWith<_MemberInfoState> get copyWith => __$MemberInfoStateCopyWithImpl<_MemberInfoState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberInfoState&&(identical(other.memberStatus, memberStatus) || other.memberStatus == memberStatus)&&(identical(other.subscriptionsStatus, subscriptionsStatus) || other.subscriptionsStatus == subscriptionsStatus)&&(identical(other.attendanceStatus, attendanceStatus) || other.attendanceStatus == attendanceStatus)&&(identical(other.activitiesStatus, activitiesStatus) || other.activitiesStatus == activitiesStatus)&&(identical(other.updateStatus, updateStatus) || other.updateStatus == updateStatus)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&(identical(other.member, member) || other.member == member)&&const DeepCollectionEquality().equals(other.subscriptions, _subscriptions)&&const DeepCollectionEquality().equals(other.attendance, _attendance)&&const DeepCollectionEquality().equals(other.activities, _activities)&&(identical(other.memberError, memberError) || other.memberError == memberError)&&(identical(other.subscriptionsError, subscriptionsError) || other.subscriptionsError == subscriptionsError)&&(identical(other.attendanceError, attendanceError) || other.attendanceError == attendanceError)&&(identical(other.activitiesError, activitiesError) || other.activitiesError == activitiesError)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,memberStatus,subscriptionsStatus,attendanceStatus,activitiesStatus,updateStatus,deleteStatus,member,const DeepCollectionEquality().hash(_subscriptions),const DeepCollectionEquality().hash(_attendance),const DeepCollectionEquality().hash(_activities),memberError,subscriptionsError,attendanceError,activitiesError,actionError);
}

@override
String toString() {
    return 'MemberInfoState(memberStatus: $memberStatus, subscriptionsStatus: $subscriptionsStatus, attendanceStatus: $attendanceStatus, activitiesStatus: $activitiesStatus, updateStatus: $updateStatus, deleteStatus: $deleteStatus, member: $member, subscriptions: $subscriptions, attendance: $attendance, activities: $activities, memberError: $memberError, subscriptionsError: $subscriptionsError, attendanceError: $attendanceError, activitiesError: $activitiesError, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class _$MemberInfoStateCopyWith<$Res> implements $MemberInfoStateCopyWith<$Res> {
  factory _$MemberInfoStateCopyWith(_MemberInfoState value, $Res Function(_MemberInfoState) _then) = __$MemberInfoStateCopyWithImpl;
@override @useResult
$Res call({
 InfoStatus memberStatus, InfoStatus subscriptionsStatus, InfoStatus attendanceStatus, InfoStatus activitiesStatus, InfoStatus updateStatus, InfoStatus deleteStatus, MemberShowCardModel? member, List<GymSubscriptionResponseModel> subscriptions, List<MemberLogedinResponseModel> attendance, List<MemberActivityLogedinModel> activities, String? memberError, String? subscriptionsError, String? attendanceError, String? activitiesError, String? actionError
});


@override $MemberShowCardModelCopyWith<$Res>? get member;

}
/// @nodoc
class __$MemberInfoStateCopyWithImpl<$Res>
    implements _$MemberInfoStateCopyWith<$Res> {
  __$MemberInfoStateCopyWithImpl(this._self, this._then);

  final _MemberInfoState _self;
  final $Res Function(_MemberInfoState) _then;

/// Create a copy of MemberInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberStatus = null,Object? subscriptionsStatus = null,Object? attendanceStatus = null,Object? activitiesStatus = null,Object? updateStatus = null,Object? deleteStatus = null,Object? member = freezed,Object? subscriptions = null,Object? attendance = null,Object? activities = null,Object? memberError = freezed,Object? subscriptionsError = freezed,Object? attendanceError = freezed,Object? activitiesError = freezed,Object? actionError = freezed,}) {
  return _then(_MemberInfoState(
memberStatus: null == memberStatus ? _self.memberStatus : memberStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,subscriptionsStatus: null == subscriptionsStatus ? _self.subscriptionsStatus : subscriptionsStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,attendanceStatus: null == attendanceStatus ? _self.attendanceStatus : attendanceStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,activitiesStatus: null == activitiesStatus ? _self.activitiesStatus : activitiesStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,updateStatus: null == updateStatus ? _self.updateStatus : updateStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as InfoStatus,member: freezed == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberShowCardModel?,subscriptions: null == subscriptions ? _self._subscriptions : subscriptions // ignore: cast_nullable_to_non_nullable
as List<GymSubscriptionResponseModel>,attendance: null == attendance ? _self._attendance : attendance // ignore: cast_nullable_to_non_nullable
as List<MemberLogedinResponseModel>,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<MemberActivityLogedinModel>,memberError: freezed == memberError ? _self.memberError : memberError // ignore: cast_nullable_to_non_nullable
as String?,subscriptionsError: freezed == subscriptionsError ? _self.subscriptionsError : subscriptionsError // ignore: cast_nullable_to_non_nullable
as String?,attendanceError: freezed == attendanceError ? _self.attendanceError : attendanceError // ignore: cast_nullable_to_non_nullable
as String?,activitiesError: freezed == activitiesError ? _self.activitiesError : activitiesError // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MemberInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberShowCardModelCopyWith<$Res>? get member {
    if (_self.member == null) {
    return null;
  }

  return $MemberShowCardModelCopyWith<$Res>(_self.member!, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}

// dart format on
