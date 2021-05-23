import 'comment.dart';

abstract class CommentComposer {
  Comment compose(String author, String content);
}
