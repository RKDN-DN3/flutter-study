import 'package:json_annotation/json_annotation.dart';
part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: "room_id")
  String? room_id;

  @JsonKey(name: "user_id")
  String? user_id;

  @JsonKey(name: "role")
  String? role;

  Token({this.room_id, this.user_id, this.role});

  factory Token.fromJson(Map<String, dynamic> srcJson) =>
      _$TokenFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
