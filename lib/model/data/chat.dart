class Chat {
  String? content;
  String? id;
  dynamic timeAt;

  Chat({this.content, this.id, this.timeAt});

  Chat.fromJson(Map<String, dynamic> json)
      : content = json["content"],
        id = json["id"],
        timeAt = json["timeAt"];

  Map<String, dynamic> toJson() =>
      {"content": content, "id": id, "timeAt": timeAt};
}
