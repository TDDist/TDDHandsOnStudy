import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'comment_composer.dart';

Row form(CommentComposer commentComposer, Function onNewComment) {
  TextEditingController _authorTextController = TextEditingController();
  TextEditingController _contentTextController = TextEditingController();

  void _handleSubmit() {
    final comment = commentComposer.compose(_authorTextController.text, _contentTextController.text);
    onNewComment(comment);
    _authorTextController.text = "";
    _contentTextController.text = "";
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


  return Row(
    children: [
      Container(
          width: 400, child: _inputTextField(_authorTextController, "작성자")),
      Container(
          width: 400, child: _inputTextField(_contentTextController, "내용")),
      CupertinoButton(child: Text("입력"), onPressed: _handleSubmit)
    ],
  );
}
