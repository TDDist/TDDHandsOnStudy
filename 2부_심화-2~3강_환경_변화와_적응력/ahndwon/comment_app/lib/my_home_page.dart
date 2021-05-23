import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'comment.dart';
import 'comment_composer.dart';
import 'form.dart';

class MyHomePage extends StatefulWidget {
  final CommentComposer commentComposer;

  MyHomePage({Key key, this.title, this.commentComposer}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Comment> items = [];

  void onNewComment(Comment comment) {
    setState(() {
      items.add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            form(widget.commentComposer, onNewComment),
            Expanded(child: buildListView()),
          ],
        ));
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[items.length - 1 - index];
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text("- " + item.content),
                Text(item.author),
                Text(item.date),
              ],
            ),
          );
        });
  }
}
