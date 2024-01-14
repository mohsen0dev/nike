import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/data/repasitory/comment_repository.dart';
import 'package:nike/data/source/comment_data_source.dart';
import 'package:nike/screen/product/comment/bloc/comment_bloc.dart';
import 'package:nike/utils/constants.dart';
import 'package:nike/utils/theme.dart';

class CommentList extends StatelessWidget {
  final int productId;
  const CommentList({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final commentRepository = CommentRepository(
        dataSource: CommentRemoteDataSource(httpClient: httpClient));
    return BlocProvider(
      create: (context) {
        final CommentListBloc bloc = CommentListBloc(
          commentRepository: commentRepository,
          productId: productId,
        );
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSuccess) {
            return Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              // color: Colors.amber,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: defaultScrollPhysics,
                shrinkWrap: true,
                itemCount: state.comments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: LightThemeColors.secondaryTextColor
                              .withOpacity(0.6),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.comments[index].title,
                              style: textTheme.bodyMedium!
                                  .apply(fontWeightDelta: 4),
                            ),
                            Text(
                              state.comments[index].date,
                              style: textTheme.bodySmall!
                                  .apply(decoration: TextDecoration.none),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          state.comments[index].email,
                          style: textTheme.bodySmall!
                              .apply(decoration: TextDecoration.none),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Divider(
                          color: LightThemeColors.secondaryTextColor
                              .withOpacity(0.2),
                          endIndent: MediaQuery.sizeOf(context).width * 0.1,
                          indent: MediaQuery.sizeOf(context).width * 0.1,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(state.comments[index].content),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          if (state is CommentListError) {
            return Text(state.exception.toString());
          }
          if (state is CommentListLoaded) {
            // Future.delayed(const Duration(seconds: 1));
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
