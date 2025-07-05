import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';

class MovieCard extends StatelessWidget {
  final String label;
  final String? imageUrl;
  final VoidCallback? onTap;

  const MovieCard({
    required this.label,
    required this.imageUrl,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: 10.circularRadius,
      child: InkWell(
        borderRadius: 10.circularRadius,
        onTap: onTap,
        child: Ink(
          height: 180,
          width: double.infinity,
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
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: 10.circularRadius,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                  ),
                ),
              ),
              Padding(
                padding: 16.padAll,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    label,
                    style: context.style18W600.copyWith(
                      color: Colors.white,
                      height: 1.25,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black54,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
