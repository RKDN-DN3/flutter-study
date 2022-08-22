import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "password")
  String? password;

  User({this.username, this.password});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
