import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/models/prodoct_model.dart';
import 'package:nike/screen/product/comment/comment_list.dart';
import 'package:nike/utils/constants.dart';
import 'package:nike/utils/number_formating.dart';
import 'package:nike/utils/theme.dart';

class DetalsScreen extends StatelessWidget {
  final ProductEntity mahsolat;
  const DetalsScreen({super.key, required this.mahsolat});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: Text(
              'افزودنت به سبد خرید',
              style: textTheme.titleMedium!.apply(
                color: LightThemeColors.secondaryTextColor,
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          physics: defaultScrollPhysics,
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outline,
                  ),
                ),
              ],
              expandedHeight: MediaQuery.sizeOf(context).width * 0.8,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: mahsolat.imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  // height: 100,
                  width: 150,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              mahsolat.title,
                              style: textTheme.titleLarge,
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  mahsolat.previousPrice
                                          .formatNumberWithCommas() +
                                      vahed,
                                  style: textTheme.bodySmall,
                                ),
                                Text(mahsolat.price.formatNumberWithCommas() +
                                    vahed),
                              ]),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'این کتونی با جنس کفی نرم برای پیاده روی مناسب می باشد و تقریبا فشاری روی پا نمی اورد',
                        // style: textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات کاربران',
                              style: textTheme.titleMedium!.apply(
                                color: LightThemeColors.secondaryTextColor,
                              ),
                            ),
                            TextButton(
                                onPressed: () {}, child: const Text('ثبت نظر'))
                          ]),
                    ]),
              ),
            ),
            SliverToBoxAdapter(
              child: CommentList(productId: mahsolat.id),
            ),
          ],
        ),
      ),
    );
  }
}
