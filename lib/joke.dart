import 'package:json_annotation/json_annotation.dart';

part 'joke.g.dart';

@JsonSerializable()
class Joke {
  String id;
  String value;
  String sourceUrl;
  String icon_url;
  List<String> categories;
  String created_at;
  String updated_at;
  String url;

  Joke(this.id, this.value, this.sourceUrl, this.icon_url, this.categories,
      this.created_at, this.updated_at, this.url);

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);

  Map<String, dynamic> toJson() => _$JokeToJson(this);
}
