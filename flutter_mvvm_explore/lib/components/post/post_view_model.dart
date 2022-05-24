import 'package:flutter_mvvm_explore/models/post.dart';

class PostViewModel  {
  late Post _post;

  setPost(Post post) {
    _post = post;
  }

  Post get post => _post;
}
