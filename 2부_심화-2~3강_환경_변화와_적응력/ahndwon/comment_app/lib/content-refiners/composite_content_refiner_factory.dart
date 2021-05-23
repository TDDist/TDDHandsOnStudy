import 'package:comment_app/content-refiners/comment_refiner.dart';

class CompositeContentRefinerFactory implements CommentRefiner {
  final List<CommentRefiner> refiners;

  CompositeContentRefinerFactory(this.refiners);

  @override
  String refine(String input) {
    refiners.forEach((refiner) {
      input = refiner.refine(input);
    });
    return input;
  }
}
