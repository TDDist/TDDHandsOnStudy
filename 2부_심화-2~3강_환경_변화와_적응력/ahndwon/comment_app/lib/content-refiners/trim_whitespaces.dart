import 'comment_refiner.dart';

class TrimWhiteSpaces implements CommentRefiner {
  @override
  String refine(String input) {
    return input.trim();
  }
}