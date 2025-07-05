// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:stacked/stacked.dart';
import 'package:ticket_booking_app/core/utils/app_extensions.dart';
import 'package:ticket_booking_app/features/video_player/video_player_screen.dart';
import 'package:ticket_booking_app/models/traileres_record.dart';

class MovieDetailViewModel extends BaseViewModel {
  final BuildContext context;
  final int? movieId;

  Trailer? trailer;

  MovieDetailViewModel(this.context, this.movieId);

  Future<void> getMovieTrailer() async {
    if (trailer != null) {
      context.push(VideoPlayerScreen(trailer?.key));
      return;
    }

    setBusy(true);

    final resp = await client.get<TrailersRecord>(
      endpoint: '/movie/$movieId/videos',
      fromJson: TrailersRecord.fromJson,
    );

    if (resp.success) {
      trailer = resp.data?.trailers.firstWhereOrNull(
        (t) => t.type == 'Trailer',
      );
      context.push(VideoPlayerScreen(trailer?.key));
    } else {
      context.showErrorSnack('${resp.message}');
    }

    setBusy(false);
  }
}
