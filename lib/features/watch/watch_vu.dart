import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:stacked/stacked.dart';
import 'package:ticket_booking_app/core/constants/app_colors.dart';
import 'package:ticket_booking_app/features/movie_detail/movie_detail_vu.dart';
import 'package:ticket_booking_app/features/search_movie/search_movie_vu.dart';
import 'package:ticket_booking_app/widgets/card/movie_card.dart';

import 'watch_vm.dart';

class WatchView extends StackedView<WatchViewModel> {
  const WatchView({super.key});

  @override
  Widget builder(
    BuildContext context,
    WatchViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              title: Text('Watch'),
              actions: [
                IconButton(
                  onPressed: () {
                    context.push(SearchMovieView());
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            body: Container(
              color: AppColors.backgroundColor,
              child: ListView.builder(
                itemCount: viewModel.movies.length,
                padding: 16.padAll,
                itemBuilder: (context, index) {
                  final movie = viewModel.movies[index];
                  return Padding(
                    padding: 8.padY,
                    child: MovieCard(
                      label: '${movie.title}',
                      imageUrl: movie.posterPath ?? movie.backdropPath,
                      onTap: () {
                        context.push(MovieDetailView(movie));
                      },
                    ),
                  );
                },
              ),
            ),
          );
  }

  @override
  WatchViewModel viewModelBuilder(BuildContext context) {
    return WatchViewModel(context);
  }
}
