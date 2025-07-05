// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:stacked/stacked.dart';
import 'package:ticket_booking_app/core/utils/app_extensions.dart';
import 'package:ticket_booking_app/models/movies_record.dart';
import 'package:ticket_booking_app/models/searched_movies_record.dart';

class SearchMovieViewModel extends BaseViewModel {
  final BuildContext context;
  final searchController = TextEditingController();

  List<Movie> movies = [];

  SearchMovieViewModel(this.context);

  void onSearch(String query) {
    if (query.trim().isEmpty && query.isNotEmpty) return;
    _getSearchedMovies(query);
  }

  void onClearSearch() {
    searchController.text = '';
    movies = [];
    notifyListeners();
  }

  Future<void> _getSearchedMovies(String query) async {
    setBusy(true);

    final resp = await client.get<SearchedMoviesRecord>(
      endpoint: '/search/movie',
      request: {'query': query.trim()},
      fromJson: SearchedMoviesRecord.fromJson,
    );

    if (resp.success) {
      movies = resp.data?.movies ?? [];
    } else {
      context.showErrorSnack('${resp.message}');
    }

    setBusy(false);
  }
}
