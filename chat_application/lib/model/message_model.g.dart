// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      text: json['text'] as String,
      isSentByMe: json['isSentByMe'] as bool,
      isVoiceMessage: json['isVoiceMessage'] as bool? ?? false,
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'isSentByMe': instance.isSentByMe,
      'isVoiceMessage': instance.isVoiceMessage,
    };
