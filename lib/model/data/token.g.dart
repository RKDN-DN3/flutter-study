// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      room_id: json['room_id'] as String?,
      user_id: json['user_id'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'room_id': instance.room_id,
      'user_id': instance.user_id,
      'role': instance.role,
    };
