// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      language: json['language'] as String? ?? 'es',
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      darkMode: json['darkMode'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'birthDate': instance.birthDate?.toIso8601String(),
      'language': instance.language,
      'notificationsEnabled': instance.notificationsEnabled,
      'darkMode': instance.darkMode,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
