// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activities_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActivitiesState {

 ActivitiesStatus get listStatus; List<ActivitiesModel> get activities; ActivitiesStatus get lookupStatus; List<MemberActivityLogedinModel> get memberActivities; String? get lookupCode;/// بيانات العضو (بطاقة العضو) اللي اتجابت من ReceptionRepo.memberShowCard.
 MemberShowCardModel? get memberCard;/// الكود مش متسجل على السيستم (404) -> الشاشة تحوّل لتسجيل عضو جديد.
 bool get memberNotFound; ActivitiesStatus get checkinStatus; ActivityCheckinResponseModel? get checkinData;/// النشاط اللي بيتسجّل له حضور حالياً (عشان الـ loading على زراره بس).
 int? get checkinActivityId; ActivitiesStatus get subscribeStatus; MakeActivitySubResponseModel? get subscriptionData;/// ملخص نتيجة التسجيل في أكتر من نشاط (نجاح/فشل كل نشاط).
 String? get subscribeMessage; String? get errorMessage;
/// Create a copy of ActivitiesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivitiesStateCopyWith<ActivitiesState> get copyWith => _$ActivitiesStateCopyWithImpl<ActivitiesState>(this as ActivitiesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ActivitiesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivitiesState&&(identical(other.listStatus, _this.listStatus) || other.listStatus == _this.listStatus)&&const DeepCollectionEquality().equals(other.activities, _this.activities)&&(identical(other.lookupStatus, _this.lookupStatus) || other.lookupStatus == _this.lookupStatus)&&const DeepCollectionEquality().equals(other.memberActivities, _this.memberActivities)&&(identical(other.lookupCode, _this.lookupCode) || other.lookupCode == _this.lookupCode)&&(identical(other.memberCard, _this.memberCard) || other.memberCard == _this.memberCard)&&(identical(other.memberNotFound, _this.memberNotFound) || other.memberNotFound == _this.memberNotFound)&&(identical(other.checkinStatus, _this.checkinStatus) || other.checkinStatus == _this.checkinStatus)&&(identical(other.checkinData, _this.checkinData) || other.checkinData == _this.checkinData)&&(identical(other.checkinActivityId, _this.checkinActivityId) || other.checkinActivityId == _this.checkinActivityId)&&(identical(other.subscribeStatus, _this.subscribeStatus) || other.subscribeStatus == _this.subscribeStatus)&&(identical(other.subscriptionData, _this.subscriptionData) || other.subscriptionData == _this.subscriptionData)&&(identical(other.subscribeMessage, _this.subscribeMessage) || other.subscribeMessage == _this.subscribeMessage)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as ActivitiesState;
  return Object.hash(runtimeType,_this.listStatus,const DeepCollectionEquality().hash(_this.activities),_this.lookupStatus,const DeepCollectionEquality().hash(_this.memberActivities),_this.lookupCode,_this.memberCard,_this.memberNotFound,_this.checkinStatus,_this.checkinData,_this.checkinActivityId,_this.subscribeStatus,_this.subscriptionData,_this.subscribeMessage,_this.errorMessage);
}

@override
String toString() {
  final _this = this as ActivitiesState;
  return 'ActivitiesState(listStatus: ${_this.listStatus}, activities: ${_this.activities}, lookupStatus: ${_this.lookupStatus}, memberActivities: ${_this.memberActivities}, lookupCode: ${_this.lookupCode}, memberCard: ${_this.memberCard}, memberNotFound: ${_this.memberNotFound}, checkinStatus: ${_this.checkinStatus}, checkinData: ${_this.checkinData}, checkinActivityId: ${_this.checkinActivityId}, subscribeStatus: ${_this.subscribeStatus}, subscriptionData: ${_this.subscriptionData}, subscribeMessage: ${_this.subscribeMessage}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $ActivitiesStateCopyWith<$Res>  {
  factory $ActivitiesStateCopyWith(ActivitiesState value, $Res Function(ActivitiesState) _then) = _$ActivitiesStateCopyWithImpl;
@useResult
$Res call({
 ActivitiesStatus listStatus, List<ActivitiesModel> activities, ActivitiesStatus lookupStatus, List<MemberActivityLogedinModel> memberActivities, String? lookupCode, MemberShowCardModel? memberCard, bool memberNotFound, ActivitiesStatus checkinStatus, ActivityCheckinResponseModel? checkinData, int? checkinActivityId, ActivitiesStatus subscribeStatus, MakeActivitySubResponseModel? subscriptionData, String? subscribeMessage, String? errorMessage
});


$MemberShowCardModelCopyWith<$Res>? get memberCard;

}
/// @nodoc
class _$ActivitiesStateCopyWithImpl<$Res>
    implements $ActivitiesStateCopyWith<$Res> {
  _$ActivitiesStateCopyWithImpl(this._self, this._then);

  final ActivitiesState _self;
  final $Res Function(ActivitiesState) _then;

/// Create a copy of ActivitiesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listStatus = null,Object? activities = null,Object? lookupStatus = null,Object? memberActivities = null,Object? lookupCode = freezed,Object? memberCard = freezed,Object? memberNotFound = null,Object? checkinStatus = null,Object? checkinData = freezed,Object? checkinActivityId = freezed,Object? subscribeStatus = null,Object? subscriptionData = freezed,Object? subscribeMessage = freezed,Object? errorMessage = freezed,}) {
  return _then(ActivitiesState(
listStatus: null == listStatus ? _self.listStatus : listStatus // ignore: cast_nullable_to_non_nullable
as ActivitiesStatus,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<ActivitiesModel>,lookupStatus: null == lookupStatus ? _self.lookupStatus : lookupStatus // ignore: cast_nullable_to_non_nullable
as ActivitiesStatus,memberActivities: null == memberActivities ? _self.memberActivities : memberActivities // ignore: cast_nullable_to_non_nullable
as List<MemberActivityLogedinModel>,lookupCode: freezed == lookupCode ? _self.lookupCode : lookupCode // ignore: cast_nullable_to_non_nullable
as String?,memberCard: freezed == memberCard ? _self.memberCard : memberCard // ignore: cast_nullable_to_non_nullable
as MemberShowCardModel?,memberNotFound: null == memberNotFound ? _self.memberNotFound : memberNotFound // ignore: cast_nullable_to_non_nullable
as bool,checkinStatus: null == checkinStatus ? _self.checkinStatus : checkinStatus // ignore: cast_nullable_to_non_nullable
as ActivitiesStatus,checkinData: freezed == checkinData ? _self.checkinData : checkinData // ignore: cast_nullable_to_non_nullable
as ActivityCheckinResponseModel?,checkinActivityId: freezed == checkinActivityId ? _self.checkinActivityId : checkinActivityId // ignore: cast_nullable_to_non_nullable
as int?,subscribeStatus: null == subscribeStatus ? _self.subscribeStatus : subscribeStatus // ignore: cast_nullable_to_non_nullable
as ActivitiesStatus,subscriptionData: freezed == subscriptionData ? _self.subscriptionData : subscriptionData // ignore: cast_nullable_to_non_nullable
as MakeActivitySubResponseModel?,subscribeMessage: freezed == subscribeMessage ? _self.subscribeMessage : subscribeMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ActivitiesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberShowCardModelCopyWith<$Res>? get memberCard {
    if (_self.memberCard == null) {
    return null;
  }

  return $MemberShowCardModelCopyWith<$Res>(_self.memberCard!, (value) {
    return _then(_self.copyWith(memberCard: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActivitiesState].
extension ActivitiesStatePatterns on ActivitiesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivitiesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivitiesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivitiesState value)  $default,){
final _that = this;
switch (_that) {
case _ActivitiesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivitiesState value)?  $default,){
final _that = this;
switch (_that) {
case _ActivitiesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ActivitiesStatus listStatus,  List<ActivitiesModel> activities,  ActivitiesStatus lookupStatus,  List<MemberActivityLogedinModel> memberActivities,  String? lookupCode,  MemberShowCardModel? memberCard,  bool memberNotFound,  ActivitiesStatus checkinStatus,  ActivityCheckinResponseModel? checkinData,  int? checkinActivityId,  ActivitiesStatus subscribeStatus,  MakeActivitySubResponseModel? subscriptionData,  String? subscribeMessage,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivitiesState() when $default != null:
return $default(_that.listStatus,_that.activities,_that.lookupStatus,_that.memberActivities,_that.lookupCode,_that.memberCard,_that.memberNotFound,_that.checkinStatus,_that.checkinData,_that.checkinActivityId,_that.subscribeStatus,_that.subscriptionData,_that.subscribeMessage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ActivitiesStatus listStatus,  List<ActivitiesModel> activities,  ActivitiesStatus lookupStatus,  List<MemberActivityLogedinModel> memberActivities,  String? lookupCode,  MemberShowCardModel? memberCard,  bool memberNotFound,  ActivitiesStatus checkinStatus,  ActivityCheckinResponseModel? checkinData,  int? checkinActivityId,  ActivitiesStatus subscribeStatus,  MakeActivitySubResponseModel? subscriptionData,  String? subscribeMessage,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ActivitiesState():
return $default(_that.listStatus,_that.activities,_that.lookupStatus,_that.memberActivities,_that.lookupCode,_that.memberCard,_that.memberNotFound,_that.checkinStatus,_that.checkinData,_that.checkinActivityId,_that.subscribeStatus,_that.subscriptionData,_that.subscribeMessage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ActivitiesStatus listStatus,  List<ActivitiesModel> activities,  ActivitiesStatus lookupStatus,  List<MemberActivityLogedinModel> memberActivities,  String? lookupCode,  MemberShowCardModel? memberCard,  bool memberNotFound,  ActivitiesStatus checkinStatus,  ActivityCheckinResponseModel? checkinData,  int? checkinActivityId,  ActivitiesStatus subscribeStatus,  MakeActivitySubResponseModel? subscriptionData,  String? subscribeMessage,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ActivitiesState() when $default != null:
return $default(_that.listStatus,_that.activities,_that.lookupStatus,_that.memberActivities,_that.lookupCode,_that.memberCard,_that.memberNotFound,_that.checkinStatus,_that.checkinData,_that.checkinActivityId,_that.subscribeStatus,_that.subscriptionData,_that.subscribeMessage,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ActivitiesState implements ActivitiesState {
  const _ActivitiesState({this.listStatus = ActivitiesStatus.initial,  List<ActivitiesModel> activities = const [], this.lookupStatus = ActivitiesStatus.initial,  List<MemberActivityLogedinModel> memberActivities = const <MemberActivityLogedinModel>[], this.lookupCode, this.memberCard, this.memberNotFound = false, this.checkinStatus = ActivitiesStatus.initial, this.checkinData, this.checkinActivityId, this.subscribeStatus = ActivitiesStatus.initial, this.subscriptionData, this.subscribeMessage, this.errorMessage}): _activities = activities,_memberActivities = memberActivities;
  

@override@JsonKey() final  ActivitiesStatus listStatus;
 final  List<ActivitiesModel> _activities;
@override@JsonKey() List<ActivitiesModel> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}

@override@JsonKey() final  ActivitiesStatus lookupStatus;
 final  List<MemberActivityLogedinModel> _memberActivities;
@override@JsonKey() List<MemberActivityLogedinModel> get memberActivities {
  if (_memberActivities is EqualUnmodifiableListView) return _memberActivities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberActivities);
}

@override final  String? lookupCode;
/// بيانات العضو (بطاقة العضو) اللي اتجابت من ReceptionRepo.memberShowCard.
@override final  MemberShowCardModel? memberCard;
/// الكود مش متسجل على السيستم (404) -> الشاشة تحوّل لتسجيل عضو جديد.
@override@JsonKey() final  bool memberNotFound;
@override@JsonKey() final  ActivitiesStatus checkinStatus;
@override final  ActivityCheckinResponseModel? checkinData;
/// النشاط اللي بيتسجّل له حضور حالياً (عشان الـ loading على زراره بس).
@override final  int? checkinActivityId;
@override@JsonKey() final  ActivitiesStatus subscribeStatus;
@override final  MakeActivitySubResponseModel? subscriptionData;
/// ملخص نتيجة التسجيل في أكتر من نشاط (نجاح/فشل كل نشاط).
@override final  String? subscribeMessage;
@override final  String? errorMessage;

/// Create a copy of ActivitiesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivitiesStateCopyWith<_ActivitiesState> get copyWith => __$ActivitiesStateCopyWithImpl<_ActivitiesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivitiesState&&(identical(other.listStatus, listStatus) || other.listStatus == listStatus)&&const DeepCollectionEquality().equals(other.activities, _activities)&&(identical(other.lookupStatus, lookupStatus) || other.lookupStatus == lookupStatus)&&const DeepCollectionEquality().equals(other.memberActivities, _memberActivities)&&(identical(other.lookupCode, lookupCode) || other.lookupCode == lookupCode)&&(identical(other.memberCard, memberCard) || other.memberCard == memberCard)&&(identical(other.memberNotFound, memberNotFound) || other.memberNotFound == memberNotFound)&&(identical(other.checkinStatus, checkinStatus) || other.checkinStatus == checkinStatus)&&(identical(other.checkinData, checkinData) || other.checkinData == checkinData)&&(identical(other.checkinActivityId, checkinActivityId) || other.checkinActivityId == checkinActivityId)&&(identical(other.subscribeStatus, subscribeStatus) || other.subscribeStatus == subscribeStatus)&&(identical(other.subscriptionData, subscriptionData) || other.subscriptionData == subscriptionData)&&(identical(other.subscribeMessage, subscribeMessage) || other.subscribeMessage == subscribeMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,listStatus,const DeepCollectionEquality().hash(_activities),lookupStatus,const DeepCollectionEquality().hash(_memberActivities),lookupCode,memberCard,memberNotFound,checkinStatus,checkinData,checkinActivityId,subscribeStatus,subscriptionData,subscribeMessage,errorMessage);
}

@override
String toString() {
    return 'ActivitiesState(listStatus: $listStatus, activities: $activities, lookupStatus: $lookupStatus, memberActivities: $memberActivities, lookupCode: $lookupCode, memberCard: $memberCard, memberNotFound: $memberNotFound, checkinStatus: $checkinStatus, checkinData: $checkinData, checkinActivityId: $checkinActivityId, subscribeStatus: $subscribeStatus, subscriptionData: $subscriptionData, subscribeMessage: $subscribeMessage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ActivitiesStateCopyWith<$Res> implements $ActivitiesStateCopyWith<$Res> {
  factory _$ActivitiesStateCopyWith(_ActivitiesState value, $Res Function(_ActivitiesState) _then) = __$ActivitiesStateCopyWithImpl;
@override @useResult
$Res call({
 ActivitiesStatus listStatus, List<ActivitiesModel> activities, ActivitiesStatus lookupStatus, List<MemberActivityLogedinModel> memberActivities, String? lookupCode, MemberShowCardModel? memberCard, bool memberNotFound, ActivitiesStatus checkinStatus, ActivityCheckinResponseModel? checkinData, int? checkinActivityId, ActivitiesStatus subscribeStatus, MakeActivitySubResponseModel? subscriptionData, String? subscribeMessage, String? errorMessage
});


@override $MemberShowCardModelCopyWith<$Res>? get memberCard;

}
/// @nodoc
class __$ActivitiesStateCopyWithImpl<$Res>
    implements _$ActivitiesStateCopyWith<$Res> {
  __$ActivitiesStateCopyWithImpl(this._self, this._then);

  final _ActivitiesState _self;
  final $Res Function(_ActivitiesState) _then;

/// Create a copy of ActivitiesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listStatus = null,Object? activities = null,Object? lookupStatus = null,Object? memberActivities = null,Object? lookupCode = freezed,Object? memberCard = freezed,Object? memberNotFound = null,Object? checkinStatus = null,Object? checkinData = freezed,Object? checkinActivityId = freezed,Object? subscribeStatus = null,Object? subscriptionData = freezed,Object? subscribeMessage = freezed,Object? errorMessage = freezed,}) {
  return _then(_ActivitiesState(
listStatus: null == listStatus ? _self.listStatus : listStatus // ignore: cast_nullable_to_non_nullable
as ActivitiesStatus,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<ActivitiesModel>,lookupStatus: null == lookupStatus ? _self.lookupStatus : lookupStatus // ignore: cast_nullable_to_non_nullable
as ActivitiesStatus,memberActivities: null == memberActivities ? _self._memberActivities : memberActivities // ignore: cast_nullable_to_non_nullable
as List<MemberActivityLogedinModel>,lookupCode: freezed == lookupCode ? _self.lookupCode : lookupCode // ignore: cast_nullable_to_non_nullable
as String?,memberCard: freezed == memberCard ? _self.memberCard : memberCard // ignore: cast_nullable_to_non_nullable
as MemberShowCardModel?,memberNotFound: null == memberNotFound ? _self.memberNotFound : memberNotFound // ignore: cast_nullable_to_non_nullable
as bool,checkinStatus: null == checkinStatus ? _self.checkinStatus : checkinStatus // ignore: cast_nullable_to_non_nullable
as ActivitiesStatus,checkinData: freezed == checkinData ? _self.checkinData : checkinData // ignore: cast_nullable_to_non_nullable
as ActivityCheckinResponseModel?,checkinActivityId: freezed == checkinActivityId ? _self.checkinActivityId : checkinActivityId // ignore: cast_nullable_to_non_nullable
as int?,subscribeStatus: null == subscribeStatus ? _self.subscribeStatus : subscribeStatus // ignore: cast_nullable_to_non_nullable
as ActivitiesStatus,subscriptionData: freezed == subscriptionData ? _self.subscriptionData : subscriptionData // ignore: cast_nullable_to_non_nullable
as MakeActivitySubResponseModel?,subscribeMessage: freezed == subscribeMessage ? _self.subscribeMessage : subscribeMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ActivitiesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberShowCardModelCopyWith<$Res>? get memberCard {
    if (_self.memberCard == null) {
    return null;
  }

  return $MemberShowCardModelCopyWith<$Res>(_self.memberCard!, (value) {
    return _then(_self.copyWith(memberCard: value));
  });
}
}

// dart format on
