import 'comment_refiner.dart';

class CompactWhiteSpaces implements CommentRefiner {
  @override
  String refine(String input) {
    return input.indexOf("  ") < 0 ? input : refine(input.replaceAll("  ", " "));
  }
}
