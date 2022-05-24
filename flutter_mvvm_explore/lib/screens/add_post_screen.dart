import 'package:flutter/material.dart';
import 'package:flutter_mvvm_explore/models/post.dart';
import 'package:flutter_mvvm_explore/notifiers/posts_notifier.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  @override
  State createState() {
    return AddPostScreenState();
  }
}

class AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Post _post = Post();

  _showSnackBar(String text, BuildContext context) {
    final snackBar = SnackBar(content: Text(text));
    //_scaffoldKey.currentState?.showSnackBar(snackBar); // deprecated
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _createPost(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      _showSnackBar("Failed to create Post", context);
      return;
    }
    _formKey.currentState?.save();
    _post.userId =
        1; // this is hard coded currently as we don't have authService

    PostsNotifier postNotifier = Provider.of(context, listen: false);
    _post.id = postNotifier.getPostList().length + 1;
    postNotifier.uploadPost(_post).then((value) {
      if (value) {
        _showSnackBar("post added successfully", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Create a Post"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 32, right: 32, top: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Post title",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Post title cannot be empty';
                  }

                  if (value.length < 5 || value.length > 50) {
                    return 'Post title must be between 5 and 50 characters';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _post.title = value ?? '';
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 32, top: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Post Body",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Post body cannot be empty';
                  }

                  if (value.length < 5 || value.length > 100) {
                    return 'Post body must be between 5 and 100 characters';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _post.body = value ?? '';
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
              child: ElevatedButton(
                onPressed: () {
                  _createPost(context);
                },
                child: Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
