class Post {
  late int id;
  late int userId;
  late String body;
  late String title;
Post();
  Post.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    userId = data['userId'];
    body = data['body'];
    title = data['title'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'body': body,
      'title': title,
    };
  }
}
