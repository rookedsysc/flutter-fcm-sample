import 'package:json_annotation/json_annotation.dart';

part 'fcm_register_dto.g.dart';

@JsonSerializable()
class FCMRegisterReqeustDTO {
  String fcmKey;
  String os = 'iOS';

  FCMRegisterReqeustDTO({required this.fcmKey});

  factory FCMRegisterReqeustDTO.fromJson(Map<String, dynamic> json) => _$FCMRegisterReqeustDTOFromJson(json);
  Map<String, dynamic> toJson() => _$FCMRegisterReqeustDTOToJson(this);
}