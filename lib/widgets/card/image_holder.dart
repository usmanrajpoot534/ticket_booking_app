import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';

class ImageHolder extends StatelessWidget {
  final String? imageUrl;
  const ImageHolder(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 130,
      decoration: BoxDecoration(
        borderRadius: 10.circularRadius,
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            imageUrl == null
                ? 'https://www.kevingage.com/assets/clapboard.png'
                : 'https://media.themoviedb.org/t/p/w220_and_h330_face/$imageUrl',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
