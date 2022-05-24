import 'package:flutter/material.dart';
import 'package:flutter_mvvm_explore/models/post.dart';
import 'package:flutter_mvvm_explore/services/api_service.dart';

class PostsNotifier with ChangeNotifier {
  List<Post> _postList = [];

  addPostToList(Post post){
    _postList.add(post);
    notifyListeners();
  }

  setPostList(List<Post> postList) {
    _postList = [];
    _postList = postList;
    notifyListeners();
  }

  List<Post> getPostList() {
    return _postList;
  }

  Future<bool> uploadPost(Post post) async{
   return await ApiService.addPost(post, this);
  }
}
