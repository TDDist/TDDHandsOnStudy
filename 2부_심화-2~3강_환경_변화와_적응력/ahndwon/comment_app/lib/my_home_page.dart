import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'comment.dart';
import 'comment_composer.dart';

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
  TextEditingController _authorTextController;
  TextEditingController _contentTextController;
  List<Comment> items = [];

  @override
  void initState() {
    super.initState();
    _authorTextController = TextEditingController();
    _contentTextController = TextEditingController();
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
            Row(
              children: [
                Container(
                    width: 400,
                    child: _inputTextField(_authorTextController, "작성자")),
                Container(
                    width: 400,
                    child: _inputTextField(_contentTextController, "내용")),
                CupertinoButton(child: Text("입력"), onPressed: _handleSubmit)
              ],
            ),
            Expanded(child: buildListView()),
          ],
        ));
  }

  void _handleSubmit() {
    setState(() {
      items.add(widget.commentComposer
          .compose(_authorTextController.text, _contentTextController.text));
      _authorTextController.text = "";
      _contentTextController.text = "";
    });
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

  TextField _inputTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      autocorrect: true,
      autofocus: true,
      decoration: InputDecoration(
        hintText: hint,
        // hintStyle: TextStyle(
        //   color: Theme.of(context).dividerColor
        // ),
        prefixIcon: Icon(
          Icons.search,
        ),
        suffixIcon: InkWell(
            onTap: () => {
                  _authorTextController.clear(),
                  FocusScope.of(context).unfocus()
                },
            child: Icon(
              Icons.close,
              color: Colors.black,
            )),
        // hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white70,
        // focusColor: Colors.pinkAccent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    );
  }
}
