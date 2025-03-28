import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
sealed class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String text,
    required bool isSentByMe,
    @Default(false) bool isVoiceMessage,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
