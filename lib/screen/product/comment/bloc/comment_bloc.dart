import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/data/models/comment_model.dart';
import 'package:nike/data/repasitory/comment_repository.dart';
import 'package:nike/utils/exeptions.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final ICommentRepository commentRepository;
  final int productId;
  CommentListBloc({required this.commentRepository, required this.productId})
      : super(CommentListLoaded()) {
    on<CommentListEvent>((event, emit) async {
      if (event is CommentListStarted) {
        emit(CommentListLoaded());
        try {
          final comments = await commentRepository.getAll(productId: productId);
          emit(CommentListSuccess(comments));
        } catch (e) {
          emit(CommentListError(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
