import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/data/models/prodoct.dart';
import 'package:nike/data/repasitory/baner_repository.dart';
import 'package:nike/data/repasitory/product_repository.dart';
import 'package:nike/data/source/baner_source.dart';
import 'package:nike/data/source/product_data_source.dart';
import 'package:nike/screen/home/bloc/home_bloc.dart';
import 'package:nike/utils/constants.dart';
import 'package:nike/utils/number_formating.dart';
import 'package:nike/utils/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme themData = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerRepository: BannerRepository(
                dataSource: BannerDataSource(httpClient: httpClient)),
            productRepository: ProductRepository(
                dataSource: ProductRemoteDataSource(httpClient: httpClient)));
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeSuccess) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    switch (i) {
                      //! logo
                      case 0:
                        return Image.asset(
                          'assets/img/nike.png',
                          fit: BoxFit.contain,
                          height: 60,
                        );
                      //! banner
                      case 1:
                        return SizedBox(
                            height: 250,
                            child: PageView.builder(
                              itemCount: state.banner.length,
                              itemBuilder: (context, index) =>
                                  CachedNetworkImage(
                                imageUrl: state.banner[index].imageUrl,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                // height: 100,
                                width: 200,
                              ),
                            ));
                      //! jadid
                      case 2:
                        return SizedBox(
                            height: 350,
                            child: Column(
                              children: [
                                titleList(
                                  themData: themData,
                                  title: 'جدیدترین',
                                  onPressed: () {},
                                ),
                                Expanded(
                                    child: ListItems(
                                        productList: state.popularProduct)),
                              ],
                            ));
                      // return ProductLove(productTestt: productTestt);
                      //! bazdid
                      case 3:
                        return SizedBox(
                          height: 380,
                          child: Column(
                            children: [
                              titleList(
                                themData: themData,
                                title: 'پربازدیدترین',
                                onPressed: () {},
                              ),
                              Expanded(
                                  child: ListItems(
                                      productList: state.latestProduct)),
                            ],
                          ),
                        );

                      default:
                        return Container();
                    }
                  });
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }

  Widget titleList(
      {required String title,
      required Function() onPressed,
      required TextTheme themData}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: themData.titleMedium!.apply(
                color: LightThemeColors.secondaryTextColor,
                fontSizeFactor: 1.1),
          ),
          TextButton(
              onPressed: onPressed,
              child: Text(
                'مشاهده همه',
                style: themData.titleMedium!
                    .apply(color: LightThemeColors.primaryColor),
              )),
        ],
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({
    super.key,
    required this.productList,
  });

  final List<ProductEntity> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: productList.length,
      itemBuilder: (BuildContext context, int index) {
        var mahsolat = productList[index];
        return Container(
          // color: Colors.cyan,
          margin: const EdgeInsets.only(left: 5.0, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: mahsolat.imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    // height: 100,
                    width: 150,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.favorite_outline),
                  ),
                ],
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
                  width: 150,
                  child: Text(
                    mahsolat.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
              Text(
                '${mahsolat.previousPrice.toString().formatNumberWithCommas()} $vahed',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '${mahsolat.price.formatNumberWithCommas()} $vahed',
              ),
            ],
          ),
        );
      },
    );
  }
}
