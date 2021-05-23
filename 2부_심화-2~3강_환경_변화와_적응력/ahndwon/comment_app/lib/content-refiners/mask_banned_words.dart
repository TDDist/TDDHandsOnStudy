import 'comment_refiner.dart';

class MaskBannedWords implements CommentRefiner {
  List<String> words; // fuck, sex

  MaskBannedWords(this.words);

  @override
  String refine(String input) {
    // hello fuck sex world
    words.forEach((element) { input = input.replaceAll(element, "*");});
    // hello * * world
    return input;
  }
}