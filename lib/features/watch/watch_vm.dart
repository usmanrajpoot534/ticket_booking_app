// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:stacked/stacked.dart';
import 'package:ticket_booking_app/core/utils/app_extensions.dart';
import 'package:ticket_booking_app/models/movies_record.dart';

class WatchViewModel extends BaseViewModel {
  final BuildContext context;

  List<Movie> movies = [];

  WatchViewModel(this.context) {
    _getUpcomingMovies();
  }

  Future<void> _getUpcomingMovies() async {
    setBusy(true);

    final resp = await client.get<MoviesRecord>(
      endpoint: '/movie/upcoming',
      fromJson: MoviesRecord.fromJson,
    );

    if (resp.success) {
      movies = resp.data?.movies ?? [];
    } else {
      context.showErrorSnack(resp.message!);
    }

    setBusy(false);
  }
}
