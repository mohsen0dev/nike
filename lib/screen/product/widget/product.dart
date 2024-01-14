import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/models/prodoct_model.dart';
import 'package:nike/screen/product/details_screen.dart';
import 'package:nike/utils/constants.dart';
import 'package:nike/utils/number_formating.dart';

class ProductItems extends StatelessWidget {
  const ProductItems({
    super.key,
    required this.mahsolat,
  });

  final ProductEntity mahsolat;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.cyan,
      margin: const EdgeInsets.only(left: 5.0, right: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetalsScreen(mahsolat: mahsolat)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: mahsolat.imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
      ),
    );
  }
}
