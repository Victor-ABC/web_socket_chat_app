// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke _$JokeFromJson(Map<String, dynamic> json) {
  return Joke(
    json['id'] as String,
    json['value'] as String,
    json['sourceUrl'] as String,
    json['icon_url'] as String,
    (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
    json['created_at'] as String,
    json['updated_at'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$JokeToJson(Joke instance) => <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'sourceUrl': instance.sourceUrl,
      'icon_url': instance.icon_url,
      'categories': instance.categories,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'url': instance.url,
    };
