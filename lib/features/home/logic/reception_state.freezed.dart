// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reception_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReceptionState {

 ReceptionStatus get memberCheckinStatus; ReceptionStatus get memberLogedinStatus; ReceptionStatus get memberShowCardStatus; ReceptionStatus get liveAttendanceStatus; ReceptionStatus get sessionsCheckInStatus; ReceptionStatus get renewSubscriptionStatus; ReceptionStatus get firstFiveAttendancesStatus; List<MemberLogedinResponseModel> get fiveAttendancesData; MemberCheckintModel? get memberCheckinData; List<MemberLogedinResponseModel>? get liveAttendanceData; MemberShowCardModel? get memberShowCardData; String? get errorMessage;
/// Create a copy of ReceptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceptionStateCopyWith<ReceptionState> get copyWith => _$ReceptionStateCopyWithImpl<ReceptionState>(this as ReceptionState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReceptionState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceptionState&&(identical(other.memberCheckinStatus, _this.memberCheckinStatus) || other.memberCheckinStatus == _this.memberCheckinStatus)&&(identical(other.memberLogedinStatus, _this.memberLogedinStatus) || other.memberLogedinStatus == _this.memberLogedinStatus)&&(identical(other.memberShowCardStatus, _this.memberShowCardStatus) || other.memberShowCardStatus == _this.memberShowCardStatus)&&(identical(other.liveAttendanceStatus, _this.liveAttendanceStatus) || other.liveAttendanceStatus == _this.liveAttendanceStatus)&&(identical(other.sessionsCheckInStatus, _this.sessionsCheckInStatus) || other.sessionsCheckInStatus == _this.sessionsCheckInStatus)&&(identical(other.renewSubscriptionStatus, _this.renewSubscriptionStatus) || other.renewSubscriptionStatus == _this.renewSubscriptionStatus)&&(identical(other.firstFiveAttendancesStatus, _this.firstFiveAttendancesStatus) || other.firstFiveAttendancesStatus == _this.firstFiveAttendancesStatus)&&const DeepCollectionEquality().equals(other.fiveAttendancesData, _this.fiveAttendancesData)&&(identical(other.memberCheckinData, _this.memberCheckinData) || other.memberCheckinData == _this.memberCheckinData)&&const DeepCollectionEquality().equals(other.liveAttendanceData, _this.liveAttendanceData)&&(identical(other.memberShowCardData, _this.memberShowCardData) || other.memberShowCardData == _this.memberShowCardData)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as ReceptionState;
  return Object.hash(runtimeType,_this.memberCheckinStatus,_this.memberLogedinStatus,_this.memberShowCardStatus,_this.liveAttendanceStatus,_this.sessionsCheckInStatus,_this.renewSubscriptionStatus,_this.firstFiveAttendancesStatus,const DeepCollectionEquality().hash(_this.fiveAttendancesData),_this.memberCheckinData,const DeepCollectionEquality().hash(_this.liveAttendanceData),_this.memberShowCardData,_this.errorMessage);
}

@override
String toString() {
  final _this = this as ReceptionState;
  return 'ReceptionState(memberCheckinStatus: ${_this.memberCheckinStatus}, memberLogedinStatus: ${_this.memberLogedinStatus}, memberShowCardStatus: ${_this.memberShowCardStatus}, liveAttendanceStatus: ${_this.liveAttendanceStatus}, sessionsCheckInStatus: ${_this.sessionsCheckInStatus}, renewSubscriptionStatus: ${_this.renewSubscriptionStatus}, firstFiveAttendancesStatus: ${_this.firstFiveAttendancesStatus}, fiveAttendancesData: ${_this.fiveAttendancesData}, memberCheckinData: ${_this.memberCheckinData}, liveAttendanceData: ${_this.liveAttendanceData}, memberShowCardData: ${_this.memberShowCardData}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $ReceptionStateCopyWith<$Res>  {
  factory $ReceptionStateCopyWith(ReceptionState value, $Res Function(ReceptionState) _then) = _$ReceptionStateCopyWithImpl;
@useResult
$Res call({
 ReceptionStatus memberCheckinStatus, ReceptionStatus memberLogedinStatus, ReceptionStatus memberShowCardStatus, ReceptionStatus liveAttendanceStatus, ReceptionStatus sessionsCheckInStatus, ReceptionStatus renewSubscriptionStatus, ReceptionStatus firstFiveAttendancesStatus, List<MemberLogedinResponseModel> fiveAttendancesData, MemberCheckintModel? memberCheckinData, List<MemberLogedinResponseModel>? liveAttendanceData, MemberShowCardModel? memberShowCardData, String? errorMessage
});


$MemberShowCardModelCopyWith<$Res>? get memberShowCardData;

}
/// @nodoc
class _$ReceptionStateCopyWithImpl<$Res>
    implements $ReceptionStateCopyWith<$Res> {
  _$ReceptionStateCopyWithImpl(this._self, this._then);

  final ReceptionState _self;
  final $Res Function(ReceptionState) _then;

/// Create a copy of ReceptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberCheckinStatus = null,Object? memberLogedinStatus = null,Object? memberShowCardStatus = null,Object? liveAttendanceStatus = null,Object? sessionsCheckInStatus = null,Object? renewSubscriptionStatus = null,Object? firstFiveAttendancesStatus = null,Object? fiveAttendancesData = null,Object? memberCheckinData = freezed,Object? liveAttendanceData = freezed,Object? memberShowCardData = freezed,Object? errorMessage = freezed,}) {
  return _then(ReceptionState(
memberCheckinStatus: null == memberCheckinStatus ? _self.memberCheckinStatus : memberCheckinStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,memberLogedinStatus: null == memberLogedinStatus ? _self.memberLogedinStatus : memberLogedinStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,memberShowCardStatus: null == memberShowCardStatus ? _self.memberShowCardStatus : memberShowCardStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,liveAttendanceStatus: null == liveAttendanceStatus ? _self.liveAttendanceStatus : liveAttendanceStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,sessionsCheckInStatus: null == sessionsCheckInStatus ? _self.sessionsCheckInStatus : sessionsCheckInStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,renewSubscriptionStatus: null == renewSubscriptionStatus ? _self.renewSubscriptionStatus : renewSubscriptionStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,firstFiveAttendancesStatus: null == firstFiveAttendancesStatus ? _self.firstFiveAttendancesStatus : firstFiveAttendancesStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,fiveAttendancesData: null == fiveAttendancesData ? _self.fiveAttendancesData : fiveAttendancesData // ignore: cast_nullable_to_non_nullable
as List<MemberLogedinResponseModel>,memberCheckinData: freezed == memberCheckinData ? _self.memberCheckinData : memberCheckinData // ignore: cast_nullable_to_non_nullable
as MemberCheckintModel?,liveAttendanceData: freezed == liveAttendanceData ? _self.liveAttendanceData : liveAttendanceData // ignore: cast_nullable_to_non_nullable
as List<MemberLogedinResponseModel>?,memberShowCardData: freezed == memberShowCardData ? _self.memberShowCardData : memberShowCardData // ignore: cast_nullable_to_non_nullable
as MemberShowCardModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ReceptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberShowCardModelCopyWith<$Res>? get memberShowCardData {
    if (_self.memberShowCardData == null) {
    return null;
  }

  return $MemberShowCardModelCopyWith<$Res>(_self.memberShowCardData!, (value) {
    return _then(_self.copyWith(memberShowCardData: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReceptionState].
extension ReceptionStatePatterns on ReceptionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceptionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceptionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceptionState value)  $default,){
final _that = this;
switch (_that) {
case _ReceptionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceptionState value)?  $default,){
final _that = this;
switch (_that) {
case _ReceptionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReceptionStatus memberCheckinStatus,  ReceptionStatus memberLogedinStatus,  ReceptionStatus memberShowCardStatus,  ReceptionStatus liveAttendanceStatus,  ReceptionStatus sessionsCheckInStatus,  ReceptionStatus renewSubscriptionStatus,  ReceptionStatus firstFiveAttendancesStatus,  List<MemberLogedinResponseModel> fiveAttendancesData,  MemberCheckintModel? memberCheckinData,  List<MemberLogedinResponseModel>? liveAttendanceData,  MemberShowCardModel? memberShowCardData,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceptionState() when $default != null:
return $default(_that.memberCheckinStatus,_that.memberLogedinStatus,_that.memberShowCardStatus,_that.liveAttendanceStatus,_that.sessionsCheckInStatus,_that.renewSubscriptionStatus,_that.firstFiveAttendancesStatus,_that.fiveAttendancesData,_that.memberCheckinData,_that.liveAttendanceData,_that.memberShowCardData,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReceptionStatus memberCheckinStatus,  ReceptionStatus memberLogedinStatus,  ReceptionStatus memberShowCardStatus,  ReceptionStatus liveAttendanceStatus,  ReceptionStatus sessionsCheckInStatus,  ReceptionStatus renewSubscriptionStatus,  ReceptionStatus firstFiveAttendancesStatus,  List<MemberLogedinResponseModel> fiveAttendancesData,  MemberCheckintModel? memberCheckinData,  List<MemberLogedinResponseModel>? liveAttendanceData,  MemberShowCardModel? memberShowCardData,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ReceptionState():
return $default(_that.memberCheckinStatus,_that.memberLogedinStatus,_that.memberShowCardStatus,_that.liveAttendanceStatus,_that.sessionsCheckInStatus,_that.renewSubscriptionStatus,_that.firstFiveAttendancesStatus,_that.fiveAttendancesData,_that.memberCheckinData,_that.liveAttendanceData,_that.memberShowCardData,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReceptionStatus memberCheckinStatus,  ReceptionStatus memberLogedinStatus,  ReceptionStatus memberShowCardStatus,  ReceptionStatus liveAttendanceStatus,  ReceptionStatus sessionsCheckInStatus,  ReceptionStatus renewSubscriptionStatus,  ReceptionStatus firstFiveAttendancesStatus,  List<MemberLogedinResponseModel> fiveAttendancesData,  MemberCheckintModel? memberCheckinData,  List<MemberLogedinResponseModel>? liveAttendanceData,  MemberShowCardModel? memberShowCardData,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ReceptionState() when $default != null:
return $default(_that.memberCheckinStatus,_that.memberLogedinStatus,_that.memberShowCardStatus,_that.liveAttendanceStatus,_that.sessionsCheckInStatus,_that.renewSubscriptionStatus,_that.firstFiveAttendancesStatus,_that.fiveAttendancesData,_that.memberCheckinData,_that.liveAttendanceData,_that.memberShowCardData,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ReceptionState implements ReceptionState {
  const _ReceptionState({this.memberCheckinStatus = ReceptionStatus.initial, this.memberLogedinStatus = ReceptionStatus.initial, this.memberShowCardStatus = ReceptionStatus.initial, this.liveAttendanceStatus = ReceptionStatus.initial, this.sessionsCheckInStatus = ReceptionStatus.initial, this.renewSubscriptionStatus = ReceptionStatus.initial, this.firstFiveAttendancesStatus = ReceptionStatus.initial,  List<MemberLogedinResponseModel> fiveAttendancesData = const [], this.memberCheckinData,  List<MemberLogedinResponseModel>? liveAttendanceData, this.memberShowCardData, this.errorMessage}): _fiveAttendancesData = fiveAttendancesData,_liveAttendanceData = liveAttendanceData;
  

@override@JsonKey() final  ReceptionStatus memberCheckinStatus;
@override@JsonKey() final  ReceptionStatus memberLogedinStatus;
@override@JsonKey() final  ReceptionStatus memberShowCardStatus;
@override@JsonKey() final  ReceptionStatus liveAttendanceStatus;
@override@JsonKey() final  ReceptionStatus sessionsCheckInStatus;
@override@JsonKey() final  ReceptionStatus renewSubscriptionStatus;
@override@JsonKey() final  ReceptionStatus firstFiveAttendancesStatus;
 final  List<MemberLogedinResponseModel> _fiveAttendancesData;
@override@JsonKey() List<MemberLogedinResponseModel> get fiveAttendancesData {
  if (_fiveAttendancesData is EqualUnmodifiableListView) return _fiveAttendancesData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fiveAttendancesData);
}

@override final  MemberCheckintModel? memberCheckinData;
 final  List<MemberLogedinResponseModel>? _liveAttendanceData;
@override List<MemberLogedinResponseModel>? get liveAttendanceData {
  final value = _liveAttendanceData;
  if (value == null) return null;
  if (_liveAttendanceData is EqualUnmodifiableListView) return _liveAttendanceData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  MemberShowCardModel? memberShowCardData;
@override final  String? errorMessage;

/// Create a copy of ReceptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceptionStateCopyWith<_ReceptionState> get copyWith => __$ReceptionStateCopyWithImpl<_ReceptionState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceptionState&&(identical(other.memberCheckinStatus, memberCheckinStatus) || other.memberCheckinStatus == memberCheckinStatus)&&(identical(other.memberLogedinStatus, memberLogedinStatus) || other.memberLogedinStatus == memberLogedinStatus)&&(identical(other.memberShowCardStatus, memberShowCardStatus) || other.memberShowCardStatus == memberShowCardStatus)&&(identical(other.liveAttendanceStatus, liveAttendanceStatus) || other.liveAttendanceStatus == liveAttendanceStatus)&&(identical(other.sessionsCheckInStatus, sessionsCheckInStatus) || other.sessionsCheckInStatus == sessionsCheckInStatus)&&(identical(other.renewSubscriptionStatus, renewSubscriptionStatus) || other.renewSubscriptionStatus == renewSubscriptionStatus)&&(identical(other.firstFiveAttendancesStatus, firstFiveAttendancesStatus) || other.firstFiveAttendancesStatus == firstFiveAttendancesStatus)&&const DeepCollectionEquality().equals(other.fiveAttendancesData, _fiveAttendancesData)&&(identical(other.memberCheckinData, memberCheckinData) || other.memberCheckinData == memberCheckinData)&&const DeepCollectionEquality().equals(other.liveAttendanceData, _liveAttendanceData)&&(identical(other.memberShowCardData, memberShowCardData) || other.memberShowCardData == memberShowCardData)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,memberCheckinStatus,memberLogedinStatus,memberShowCardStatus,liveAttendanceStatus,sessionsCheckInStatus,renewSubscriptionStatus,firstFiveAttendancesStatus,const DeepCollectionEquality().hash(_fiveAttendancesData),memberCheckinData,const DeepCollectionEquality().hash(_liveAttendanceData),memberShowCardData,errorMessage);
}

@override
String toString() {
    return 'ReceptionState(memberCheckinStatus: $memberCheckinStatus, memberLogedinStatus: $memberLogedinStatus, memberShowCardStatus: $memberShowCardStatus, liveAttendanceStatus: $liveAttendanceStatus, sessionsCheckInStatus: $sessionsCheckInStatus, renewSubscriptionStatus: $renewSubscriptionStatus, firstFiveAttendancesStatus: $firstFiveAttendancesStatus, fiveAttendancesData: $fiveAttendancesData, memberCheckinData: $memberCheckinData, liveAttendanceData: $liveAttendanceData, memberShowCardData: $memberShowCardData, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ReceptionStateCopyWith<$Res> implements $ReceptionStateCopyWith<$Res> {
  factory _$ReceptionStateCopyWith(_ReceptionState value, $Res Function(_ReceptionState) _then) = __$ReceptionStateCopyWithImpl;
@override @useResult
$Res call({
 ReceptionStatus memberCheckinStatus, ReceptionStatus memberLogedinStatus, ReceptionStatus memberShowCardStatus, ReceptionStatus liveAttendanceStatus, ReceptionStatus sessionsCheckInStatus, ReceptionStatus renewSubscriptionStatus, ReceptionStatus firstFiveAttendancesStatus, List<MemberLogedinResponseModel> fiveAttendancesData, MemberCheckintModel? memberCheckinData, List<MemberLogedinResponseModel>? liveAttendanceData, MemberShowCardModel? memberShowCardData, String? errorMessage
});


@override $MemberShowCardModelCopyWith<$Res>? get memberShowCardData;

}
/// @nodoc
class __$ReceptionStateCopyWithImpl<$Res>
    implements _$ReceptionStateCopyWith<$Res> {
  __$ReceptionStateCopyWithImpl(this._self, this._then);

  final _ReceptionState _self;
  final $Res Function(_ReceptionState) _then;

/// Create a copy of ReceptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberCheckinStatus = null,Object? memberLogedinStatus = null,Object? memberShowCardStatus = null,Object? liveAttendanceStatus = null,Object? sessionsCheckInStatus = null,Object? renewSubscriptionStatus = null,Object? firstFiveAttendancesStatus = null,Object? fiveAttendancesData = null,Object? memberCheckinData = freezed,Object? liveAttendanceData = freezed,Object? memberShowCardData = freezed,Object? errorMessage = freezed,}) {
  return _then(_ReceptionState(
memberCheckinStatus: null == memberCheckinStatus ? _self.memberCheckinStatus : memberCheckinStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,memberLogedinStatus: null == memberLogedinStatus ? _self.memberLogedinStatus : memberLogedinStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,memberShowCardStatus: null == memberShowCardStatus ? _self.memberShowCardStatus : memberShowCardStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,liveAttendanceStatus: null == liveAttendanceStatus ? _self.liveAttendanceStatus : liveAttendanceStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,sessionsCheckInStatus: null == sessionsCheckInStatus ? _self.sessionsCheckInStatus : sessionsCheckInStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,renewSubscriptionStatus: null == renewSubscriptionStatus ? _self.renewSubscriptionStatus : renewSubscriptionStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,firstFiveAttendancesStatus: null == firstFiveAttendancesStatus ? _self.firstFiveAttendancesStatus : firstFiveAttendancesStatus // ignore: cast_nullable_to_non_nullable
as ReceptionStatus,fiveAttendancesData: null == fiveAttendancesData ? _self._fiveAttendancesData : fiveAttendancesData // ignore: cast_nullable_to_non_nullable
as List<MemberLogedinResponseModel>,memberCheckinData: freezed == memberCheckinData ? _self.memberCheckinData : memberCheckinData // ignore: cast_nullable_to_non_nullable
as MemberCheckintModel?,liveAttendanceData: freezed == liveAttendanceData ? _self._liveAttendanceData : liveAttendanceData // ignore: cast_nullable_to_non_nullable
as List<MemberLogedinResponseModel>?,memberShowCardData: freezed == memberShowCardData ? _self.memberShowCardData : memberShowCardData // ignore: cast_nullable_to_non_nullable
as MemberShowCardModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ReceptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberShowCardModelCopyWith<$Res>? get memberShowCardData {
    if (_self.memberShowCardData == null) {
    return null;
  }

  return $MemberShowCardModelCopyWith<$Res>(_self.memberShowCardData!, (value) {
    return _then(_self.copyWith(memberShowCardData: value));
  });
}
}

// dart format on
