import 'package:dio/dio.dart';
import 'package:nike/data/models/comment_model.dart';
import 'package:nike/utils/validate.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRemoteDataSource implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource({required this.httpClient});
  @override
  Future<List<CommentEntity>> getAll({required int productId}) async {
    final response = await httpClient.get('comment/list?product_id=$productId');
    validateResponse(response);
    final comments = (response.data as List).map((e) {
      return CommentEntity.fromJson(e);
    }).toList();
    return comments;
  }
}
