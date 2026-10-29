// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym_subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GymSubscriptionModel _$GymSubscriptionModelFromJson(
  Map<String, dynamic> json,
) => GymSubscriptionModel(
  memberId: (json['memberId'] as num).toInt(),
  packageId: (json['packageId'] as num).toInt(),
  trainerId: (json['trainerId'] as num?)?.toInt(),
);

Map<String, dynamic> _$GymSubscriptionModelToJson(
  GymSubscriptionModel instance,
) => <String, dynamic>{
  'memberId': instance.memberId,
  'packageId': instance.packageId,
  'trainerId': instance.trainerId,
};
