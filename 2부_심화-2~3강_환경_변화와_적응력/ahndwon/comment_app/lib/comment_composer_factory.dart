import 'comment.dart';
import 'comment_composer.dart';
import 'content-refiners/comment_refiner.dart';

class CommentComposerFactory implements CommentComposer {
  final CommentRefiner refiner;

  CommentComposerFactory(this.refiner);

  @override
  Comment compose(String author, String content) {
    return Comment("1", author, refiner.refine(content),
        DateTime.now().toLocal().toIso8601String());
  }
}
