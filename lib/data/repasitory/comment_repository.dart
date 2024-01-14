import 'package:nike/data/models/comment_model.dart';
import 'package:nike/data/source/comment_data_source.dart';

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;
  CommentRepository({required this.dataSource});
  @override
  Future<List<CommentEntity>> getAll({required int productId}) {
    return dataSource.getAll(productId: productId);
  }
}
