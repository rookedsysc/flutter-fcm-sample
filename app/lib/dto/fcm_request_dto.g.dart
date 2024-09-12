// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmRequest _$FcmRequestFromJson(Map<String, dynamic> json) => FcmRequest(
      title: json['title'] as String,
      body: json['body'] as String,
      image: json['image'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      target:
          $enumDecodeNullable(_$NotificationTargetEnumMap, json['target']) ??
              NotificationTarget.ALL,
    );

Map<String, dynamic> _$FcmRequestToJson(FcmRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'image': instance.image,
      'data': instance.data,
      'target': _$NotificationTargetEnumMap[instance.target]!,
    };

const _$NotificationTargetEnumMap = {
  NotificationTarget.ALL: 'ALL',
  NotificationTarget.IOS: 'IOS',
  NotificationTarget.AOS: 'AOS',
};
