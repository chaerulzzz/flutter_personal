import 'dart:convert';

class Post {
    int userId;
    int id;
    String title;
    String body;

    Post({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}

Post postFromJson(String str) {
    final jsonData = json.decode(str);
    return Post.fromJson(jsonData);
}

List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

String postToJson(Post data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}
