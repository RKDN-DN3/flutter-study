class Chat {
  String? content;
  String? id;
  dynamic timeAt;
  Chat.fromJson(Map<String, dynamic> json)
      : content = json["content"],
        id = json["id"],
        timeAt = json["timeAt"];

  Map<String, dynamic> toJson() =>
      {"content": content, "id": id, "timeAt": timeAt};
}
