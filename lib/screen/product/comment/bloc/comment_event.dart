part of 'comment_bloc.dart';

sealed class CommentListEvent extends Equatable {
  const CommentListEvent();

  @override
  List<Object> get props => [];
}

class CommentListStarted extends CommentListEvent {}