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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      case 0:
                        return Image.asset(
                          'assets/img/nike.png',
                          height: 100,
                        );
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
                                    Icon(Icons.error),
                                // height: 100,
                                width: 200,
                              ),
                            ));
                      case 2:
                        return SizedBox(
                            height: 350,
                            child:
                                ListItems(productList: state.popularProduct));
                      // return ProductLove(productTestt: productTestt);
                      case 3:
                        return Container(
                            height: 350,
                            child: ListItems(productList: state.latestProduct));

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
}

class ListItems extends StatelessWidget {
  const ListItems({
    super.key,
    required this.productList,
  });

  final List<ProductEntity> productList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      color: Colors.green,
      child: ListView.builder(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          var mahsolat = productList[index];
          return Container(
            color: Colors.blue,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  color: Colors.amber,
                  child: CachedNetworkImage(
                    imageUrl: mahsolat.imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    // height: 100,
                    width: 150,
                  ),
                ),
                SizedBox(
                    width: 150,
                    child: Text(
                      mahsolat.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                Text(mahsolat.price.toString()),
                Text(mahsolat.previousPrice.toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
