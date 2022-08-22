import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/json_serializable.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "timeAt")
  DateTime timeAt;

  Movie(this.id, this.title, this.timeAt);

  factory Movie.fromJson(Map<String, dynamic> srcJson) =>
      _$MovieFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
