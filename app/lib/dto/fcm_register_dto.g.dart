// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMRegisterReqeustDTO _$FCMRegisterReqeustDTOFromJson(
        Map<String, dynamic> json) =>
    FCMRegisterReqeustDTO(
      fcmKey: json['fcmKey'] as String,
    )..os = json['os'] as String;

Map<String, dynamic> _$FCMRegisterReqeustDTOToJson(
        FCMRegisterReqeustDTO instance) =>
    <String, dynamic>{
      'fcmKey': instance.fcmKey,
      'os': instance.os,
    };
