// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_member_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterMemberState {

/// 1 = ذكر, 2 = أنثى (نفس قيم الـ API)
 int get gender; RegisterStatus get packagesStatus; RegisterStatus get trainersStatus; RegisterStatus get activitiesStatus; List<PackageModel> get packages; List<TrainersModel> get trainers; List<ActivitiesModel> get activities; String? get lookupsError; PackageModel? get selectedPackage; TrainersModel? get selectedTrainer; ActivitiesModel? get selectedActivity; RegisterStatus get createMemberStatus; MemberDetailsModel? get createdMember; RegisterStatus get subscriptionStatus; GymSubscriptionResponseModel? get subscription; RegisterStatus get activitySubStatus; MakeActivitySubResponseModel? get activitySubscription; String? get activityError; String? get errorMessage;
/// Create a copy of RegisterMemberState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterMemberStateCopyWith<RegisterMemberState> get copyWith => _$RegisterMemberStateCopyWithImpl<RegisterMemberState>(this as RegisterMemberState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RegisterMemberState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterMemberState&&(identical(other.gender, _this.gender) || other.gender == _this.gender)&&(identical(other.packagesStatus, _this.packagesStatus) || other.packagesStatus == _this.packagesStatus)&&(identical(other.trainersStatus, _this.trainersStatus) || other.trainersStatus == _this.trainersStatus)&&(identical(other.activitiesStatus, _this.activitiesStatus) || other.activitiesStatus == _this.activitiesStatus)&&const DeepCollectionEquality().equals(other.packages, _this.packages)&&const DeepCollectionEquality().equals(other.trainers, _this.trainers)&&const DeepCollectionEquality().equals(other.activities, _this.activities)&&(identical(other.lookupsError, _this.lookupsError) || other.lookupsError == _this.lookupsError)&&(identical(other.selectedPackage, _this.selectedPackage) || other.selectedPackage == _this.selectedPackage)&&(identical(other.selectedTrainer, _this.selectedTrainer) || other.selectedTrainer == _this.selectedTrainer)&&(identical(other.selectedActivity, _this.selectedActivity) || other.selectedActivity == _this.selectedActivity)&&(identical(other.createMemberStatus, _this.createMemberStatus) || other.createMemberStatus == _this.createMemberStatus)&&(identical(other.createdMember, _this.createdMember) || other.createdMember == _this.createdMember)&&(identical(other.subscriptionStatus, _this.subscriptionStatus) || other.subscriptionStatus == _this.subscriptionStatus)&&(identical(other.subscription, _this.subscription) || other.subscription == _this.subscription)&&(identical(other.activitySubStatus, _this.activitySubStatus) || other.activitySubStatus == _this.activitySubStatus)&&(identical(other.activitySubscription, _this.activitySubscription) || other.activitySubscription == _this.activitySubscription)&&(identical(other.activityError, _this.activityError) || other.activityError == _this.activityError)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as RegisterMemberState;
  return Object.hashAll([runtimeType,_this.gender,_this.packagesStatus,_this.trainersStatus,_this.activitiesStatus,const DeepCollectionEquality().hash(_this.packages),const DeepCollectionEquality().hash(_this.trainers),const DeepCollectionEquality().hash(_this.activities),_this.lookupsError,_this.selectedPackage,_this.selectedTrainer,_this.selectedActivity,_this.createMemberStatus,_this.createdMember,_this.subscriptionStatus,_this.subscription,_this.activitySubStatus,_this.activitySubscription,_this.activityError,_this.errorMessage]);
}

@override
String toString() {
  final _this = this as RegisterMemberState;
  return 'RegisterMemberState(gender: ${_this.gender}, packagesStatus: ${_this.packagesStatus}, trainersStatus: ${_this.trainersStatus}, activitiesStatus: ${_this.activitiesStatus}, packages: ${_this.packages}, trainers: ${_this.trainers}, activities: ${_this.activities}, lookupsError: ${_this.lookupsError}, selectedPackage: ${_this.selectedPackage}, selectedTrainer: ${_this.selectedTrainer}, selectedActivity: ${_this.selectedActivity}, createMemberStatus: ${_this.createMemberStatus}, createdMember: ${_this.createdMember}, subscriptionStatus: ${_this.subscriptionStatus}, subscription: ${_this.subscription}, activitySubStatus: ${_this.activitySubStatus}, activitySubscription: ${_this.activitySubscription}, activityError: ${_this.activityError}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $RegisterMemberStateCopyWith<$Res>  {
  factory $RegisterMemberStateCopyWith(RegisterMemberState value, $Res Function(RegisterMemberState) _then) = _$RegisterMemberStateCopyWithImpl;
@useResult
$Res call({
 int gender, RegisterStatus packagesStatus, RegisterStatus trainersStatus, RegisterStatus activitiesStatus, List<PackageModel> packages, List<TrainersModel> trainers, List<ActivitiesModel> activities, String? lookupsError, PackageModel? selectedPackage, TrainersModel? selectedTrainer, ActivitiesModel? selectedActivity, RegisterStatus createMemberStatus, MemberDetailsModel? createdMember, RegisterStatus subscriptionStatus, GymSubscriptionResponseModel? subscription, RegisterStatus activitySubStatus, MakeActivitySubResponseModel? activitySubscription, String? activityError, String? errorMessage
});




}
/// @nodoc
class _$RegisterMemberStateCopyWithImpl<$Res>
    implements $RegisterMemberStateCopyWith<$Res> {
  _$RegisterMemberStateCopyWithImpl(this._self, this._then);

  final RegisterMemberState _self;
  final $Res Function(RegisterMemberState) _then;

/// Create a copy of RegisterMemberState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gender = null,Object? packagesStatus = null,Object? trainersStatus = null,Object? activitiesStatus = null,Object? packages = null,Object? trainers = null,Object? activities = null,Object? lookupsError = freezed,Object? selectedPackage = freezed,Object? selectedTrainer = freezed,Object? selectedActivity = freezed,Object? createMemberStatus = null,Object? createdMember = freezed,Object? subscriptionStatus = null,Object? subscription = freezed,Object? activitySubStatus = null,Object? activitySubscription = freezed,Object? activityError = freezed,Object? errorMessage = freezed,}) {
  return _then(RegisterMemberState(
gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as int,packagesStatus: null == packagesStatus ? _self.packagesStatus : packagesStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,trainersStatus: null == trainersStatus ? _self.trainersStatus : trainersStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,activitiesStatus: null == activitiesStatus ? _self.activitiesStatus : activitiesStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,packages: null == packages ? _self.packages : packages // ignore: cast_nullable_to_non_nullable
as List<PackageModel>,trainers: null == trainers ? _self.trainers : trainers // ignore: cast_nullable_to_non_nullable
as List<TrainersModel>,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<ActivitiesModel>,lookupsError: freezed == lookupsError ? _self.lookupsError : lookupsError // ignore: cast_nullable_to_non_nullable
as String?,selectedPackage: freezed == selectedPackage ? _self.selectedPackage : selectedPackage // ignore: cast_nullable_to_non_nullable
as PackageModel?,selectedTrainer: freezed == selectedTrainer ? _self.selectedTrainer : selectedTrainer // ignore: cast_nullable_to_non_nullable
as TrainersModel?,selectedActivity: freezed == selectedActivity ? _self.selectedActivity : selectedActivity // ignore: cast_nullable_to_non_nullable
as ActivitiesModel?,createMemberStatus: null == createMemberStatus ? _self.createMemberStatus : createMemberStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,createdMember: freezed == createdMember ? _self.createdMember : createdMember // ignore: cast_nullable_to_non_nullable
as MemberDetailsModel?,subscriptionStatus: null == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as GymSubscriptionResponseModel?,activitySubStatus: null == activitySubStatus ? _self.activitySubStatus : activitySubStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,activitySubscription: freezed == activitySubscription ? _self.activitySubscription : activitySubscription // ignore: cast_nullable_to_non_nullable
as MakeActivitySubResponseModel?,activityError: freezed == activityError ? _self.activityError : activityError // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterMemberState].
extension RegisterMemberStatePatterns on RegisterMemberState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterMemberState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterMemberState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterMemberState value)  $default,){
final _that = this;
switch (_that) {
case _RegisterMemberState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterMemberState value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterMemberState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gender,  RegisterStatus packagesStatus,  RegisterStatus trainersStatus,  RegisterStatus activitiesStatus,  List<PackageModel> packages,  List<TrainersModel> trainers,  List<ActivitiesModel> activities,  String? lookupsError,  PackageModel? selectedPackage,  TrainersModel? selectedTrainer,  ActivitiesModel? selectedActivity,  RegisterStatus createMemberStatus,  MemberDetailsModel? createdMember,  RegisterStatus subscriptionStatus,  GymSubscriptionResponseModel? subscription,  RegisterStatus activitySubStatus,  MakeActivitySubResponseModel? activitySubscription,  String? activityError,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterMemberState() when $default != null:
return $default(_that.gender,_that.packagesStatus,_that.trainersStatus,_that.activitiesStatus,_that.packages,_that.trainers,_that.activities,_that.lookupsError,_that.selectedPackage,_that.selectedTrainer,_that.selectedActivity,_that.createMemberStatus,_that.createdMember,_that.subscriptionStatus,_that.subscription,_that.activitySubStatus,_that.activitySubscription,_that.activityError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gender,  RegisterStatus packagesStatus,  RegisterStatus trainersStatus,  RegisterStatus activitiesStatus,  List<PackageModel> packages,  List<TrainersModel> trainers,  List<ActivitiesModel> activities,  String? lookupsError,  PackageModel? selectedPackage,  TrainersModel? selectedTrainer,  ActivitiesModel? selectedActivity,  RegisterStatus createMemberStatus,  MemberDetailsModel? createdMember,  RegisterStatus subscriptionStatus,  GymSubscriptionResponseModel? subscription,  RegisterStatus activitySubStatus,  MakeActivitySubResponseModel? activitySubscription,  String? activityError,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _RegisterMemberState():
return $default(_that.gender,_that.packagesStatus,_that.trainersStatus,_that.activitiesStatus,_that.packages,_that.trainers,_that.activities,_that.lookupsError,_that.selectedPackage,_that.selectedTrainer,_that.selectedActivity,_that.createMemberStatus,_that.createdMember,_that.subscriptionStatus,_that.subscription,_that.activitySubStatus,_that.activitySubscription,_that.activityError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gender,  RegisterStatus packagesStatus,  RegisterStatus trainersStatus,  RegisterStatus activitiesStatus,  List<PackageModel> packages,  List<TrainersModel> trainers,  List<ActivitiesModel> activities,  String? lookupsError,  PackageModel? selectedPackage,  TrainersModel? selectedTrainer,  ActivitiesModel? selectedActivity,  RegisterStatus createMemberStatus,  MemberDetailsModel? createdMember,  RegisterStatus subscriptionStatus,  GymSubscriptionResponseModel? subscription,  RegisterStatus activitySubStatus,  MakeActivitySubResponseModel? activitySubscription,  String? activityError,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _RegisterMemberState() when $default != null:
return $default(_that.gender,_that.packagesStatus,_that.trainersStatus,_that.activitiesStatus,_that.packages,_that.trainers,_that.activities,_that.lookupsError,_that.selectedPackage,_that.selectedTrainer,_that.selectedActivity,_that.createMemberStatus,_that.createdMember,_that.subscriptionStatus,_that.subscription,_that.activitySubStatus,_that.activitySubscription,_that.activityError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _RegisterMemberState extends RegisterMemberState {
  const _RegisterMemberState({this.gender = 1, this.packagesStatus = RegisterStatus.initial, this.trainersStatus = RegisterStatus.initial, this.activitiesStatus = RegisterStatus.initial,  List<PackageModel> packages = const <PackageModel>[],  List<TrainersModel> trainers = const <TrainersModel>[],  List<ActivitiesModel> activities = const <ActivitiesModel>[], this.lookupsError, this.selectedPackage, this.selectedTrainer, this.selectedActivity, this.createMemberStatus = RegisterStatus.initial, this.createdMember, this.subscriptionStatus = RegisterStatus.initial, this.subscription, this.activitySubStatus = RegisterStatus.initial, this.activitySubscription, this.activityError, this.errorMessage}): _packages = packages,_trainers = trainers,_activities = activities,super._();
  

/// 1 = ذكر, 2 = أنثى (نفس قيم الـ API)
@override@JsonKey() final  int gender;
@override@JsonKey() final  RegisterStatus packagesStatus;
@override@JsonKey() final  RegisterStatus trainersStatus;
@override@JsonKey() final  RegisterStatus activitiesStatus;
 final  List<PackageModel> _packages;
@override@JsonKey() List<PackageModel> get packages {
  if (_packages is EqualUnmodifiableListView) return _packages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_packages);
}

 final  List<TrainersModel> _trainers;
@override@JsonKey() List<TrainersModel> get trainers {
  if (_trainers is EqualUnmodifiableListView) return _trainers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trainers);
}

 final  List<ActivitiesModel> _activities;
@override@JsonKey() List<ActivitiesModel> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}

@override final  String? lookupsError;
@override final  PackageModel? selectedPackage;
@override final  TrainersModel? selectedTrainer;
@override final  ActivitiesModel? selectedActivity;
@override@JsonKey() final  RegisterStatus createMemberStatus;
@override final  MemberDetailsModel? createdMember;
@override@JsonKey() final  RegisterStatus subscriptionStatus;
@override final  GymSubscriptionResponseModel? subscription;
@override@JsonKey() final  RegisterStatus activitySubStatus;
@override final  MakeActivitySubResponseModel? activitySubscription;
@override final  String? activityError;
@override final  String? errorMessage;

/// Create a copy of RegisterMemberState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterMemberStateCopyWith<_RegisterMemberState> get copyWith => __$RegisterMemberStateCopyWithImpl<_RegisterMemberState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterMemberState&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.packagesStatus, packagesStatus) || other.packagesStatus == packagesStatus)&&(identical(other.trainersStatus, trainersStatus) || other.trainersStatus == trainersStatus)&&(identical(other.activitiesStatus, activitiesStatus) || other.activitiesStatus == activitiesStatus)&&const DeepCollectionEquality().equals(other.packages, _packages)&&const DeepCollectionEquality().equals(other.trainers, _trainers)&&const DeepCollectionEquality().equals(other.activities, _activities)&&(identical(other.lookupsError, lookupsError) || other.lookupsError == lookupsError)&&(identical(other.selectedPackage, selectedPackage) || other.selectedPackage == selectedPackage)&&(identical(other.selectedTrainer, selectedTrainer) || other.selectedTrainer == selectedTrainer)&&(identical(other.selectedActivity, selectedActivity) || other.selectedActivity == selectedActivity)&&(identical(other.createMemberStatus, createMemberStatus) || other.createMemberStatus == createMemberStatus)&&(identical(other.createdMember, createdMember) || other.createdMember == createdMember)&&(identical(other.subscriptionStatus, subscriptionStatus) || other.subscriptionStatus == subscriptionStatus)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&(identical(other.activitySubStatus, activitySubStatus) || other.activitySubStatus == activitySubStatus)&&(identical(other.activitySubscription, activitySubscription) || other.activitySubscription == activitySubscription)&&(identical(other.activityError, activityError) || other.activityError == activityError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,gender,packagesStatus,trainersStatus,activitiesStatus,const DeepCollectionEquality().hash(_packages),const DeepCollectionEquality().hash(_trainers),const DeepCollectionEquality().hash(_activities),lookupsError,selectedPackage,selectedTrainer,selectedActivity,createMemberStatus,createdMember,subscriptionStatus,subscription,activitySubStatus,activitySubscription,activityError,errorMessage]);
}

@override
String toString() {
    return 'RegisterMemberState(gender: $gender, packagesStatus: $packagesStatus, trainersStatus: $trainersStatus, activitiesStatus: $activitiesStatus, packages: $packages, trainers: $trainers, activities: $activities, lookupsError: $lookupsError, selectedPackage: $selectedPackage, selectedTrainer: $selectedTrainer, selectedActivity: $selectedActivity, createMemberStatus: $createMemberStatus, createdMember: $createdMember, subscriptionStatus: $subscriptionStatus, subscription: $subscription, activitySubStatus: $activitySubStatus, activitySubscription: $activitySubscription, activityError: $activityError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$RegisterMemberStateCopyWith<$Res> implements $RegisterMemberStateCopyWith<$Res> {
  factory _$RegisterMemberStateCopyWith(_RegisterMemberState value, $Res Function(_RegisterMemberState) _then) = __$RegisterMemberStateCopyWithImpl;
@override @useResult
$Res call({
 int gender, RegisterStatus packagesStatus, RegisterStatus trainersStatus, RegisterStatus activitiesStatus, List<PackageModel> packages, List<TrainersModel> trainers, List<ActivitiesModel> activities, String? lookupsError, PackageModel? selectedPackage, TrainersModel? selectedTrainer, ActivitiesModel? selectedActivity, RegisterStatus createMemberStatus, MemberDetailsModel? createdMember, RegisterStatus subscriptionStatus, GymSubscriptionResponseModel? subscription, RegisterStatus activitySubStatus, MakeActivitySubResponseModel? activitySubscription, String? activityError, String? errorMessage
});




}
/// @nodoc
class __$RegisterMemberStateCopyWithImpl<$Res>
    implements _$RegisterMemberStateCopyWith<$Res> {
  __$RegisterMemberStateCopyWithImpl(this._self, this._then);

  final _RegisterMemberState _self;
  final $Res Function(_RegisterMemberState) _then;

/// Create a copy of RegisterMemberState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gender = null,Object? packagesStatus = null,Object? trainersStatus = null,Object? activitiesStatus = null,Object? packages = null,Object? trainers = null,Object? activities = null,Object? lookupsError = freezed,Object? selectedPackage = freezed,Object? selectedTrainer = freezed,Object? selectedActivity = freezed,Object? createMemberStatus = null,Object? createdMember = freezed,Object? subscriptionStatus = null,Object? subscription = freezed,Object? activitySubStatus = null,Object? activitySubscription = freezed,Object? activityError = freezed,Object? errorMessage = freezed,}) {
  return _then(_RegisterMemberState(
gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as int,packagesStatus: null == packagesStatus ? _self.packagesStatus : packagesStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,trainersStatus: null == trainersStatus ? _self.trainersStatus : trainersStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,activitiesStatus: null == activitiesStatus ? _self.activitiesStatus : activitiesStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,packages: null == packages ? _self._packages : packages // ignore: cast_nullable_to_non_nullable
as List<PackageModel>,trainers: null == trainers ? _self._trainers : trainers // ignore: cast_nullable_to_non_nullable
as List<TrainersModel>,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<ActivitiesModel>,lookupsError: freezed == lookupsError ? _self.lookupsError : lookupsError // ignore: cast_nullable_to_non_nullable
as String?,selectedPackage: freezed == selectedPackage ? _self.selectedPackage : selectedPackage // ignore: cast_nullable_to_non_nullable
as PackageModel?,selectedTrainer: freezed == selectedTrainer ? _self.selectedTrainer : selectedTrainer // ignore: cast_nullable_to_non_nullable
as TrainersModel?,selectedActivity: freezed == selectedActivity ? _self.selectedActivity : selectedActivity // ignore: cast_nullable_to_non_nullable
as ActivitiesModel?,createMemberStatus: null == createMemberStatus ? _self.createMemberStatus : createMemberStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,createdMember: freezed == createdMember ? _self.createdMember : createdMember // ignore: cast_nullable_to_non_nullable
as MemberDetailsModel?,subscriptionStatus: null == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as GymSubscriptionResponseModel?,activitySubStatus: null == activitySubStatus ? _self.activitySubStatus : activitySubStatus // ignore: cast_nullable_to_non_nullable
as RegisterStatus,activitySubscription: freezed == activitySubscription ? _self.activitySubscription : activitySubscription // ignore: cast_nullable_to_non_nullable
as MakeActivitySubResponseModel?,activityError: freezed == activityError ? _self.activityError : activityError // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
