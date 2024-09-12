import 'package:json_annotation/json_annotation.dart';

part 'fcm_request_dto.g.dart';

@JsonSerializable()
class FcmRequest {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'body')
  final String body;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'data')
  final Map<String, dynamic>? data;

  @JsonKey(name: 'target')
  final NotificationTarget target;

  FcmRequest({
    required this.title,
    required this.body,
    this.image,
    this.data,
    this.target = NotificationTarget.ALL,
  });

  factory FcmRequest.fromJson(Map<String, dynamic> json) =>
      _$FcmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FcmRequestToJson(this);
}

enum NotificationTarget {
  @JsonValue('ALL')
  ALL,
  @JsonValue('IOS')
  IOS,
  @JsonValue('AOS')
  AOS,
}