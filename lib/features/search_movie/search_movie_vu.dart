import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:stacked/stacked.dart';
import 'package:ticket_booking_app/core/constants/app_colors.dart';
import 'package:ticket_booking_app/features/movie_detail/movie_detail_vu.dart';
import 'package:ticket_booking_app/models/movies_record.dart';
import 'package:ticket_booking_app/widgets/card/image_holder.dart';

import 'search_movie_vm.dart';

class SearchMovieView extends StackedView<SearchMovieViewModel> {
  const SearchMovieView({super.key});

  @override
  Widget builder(
    BuildContext context,
    SearchMovieViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: 16.padAll,
              alignment: Alignment.center,
              color: Colors.white,
              child: TextField(
                controller: viewModel.searchController,
                onChanged: viewModel.onSearch,
                autofocus: true,
                cursorColor: AppColors.buttonColor,
                decoration: InputDecoration(
                  hintText: 'TV shows, movies and more',
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: viewModel.onClearSearch,
                    icon: Icon(Icons.close),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: 30.circularRadius,
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: viewModel.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      padding: 16.padAll,
                      color: AppColors.backgroundColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (viewModel.movies.isNotEmpty) ...[
                            Text('Top Results', style: context.style12W500),
                            Divider(),
                          ],
                          Expanded(
                            child: ListView.builder(
                              itemCount: viewModel.movies.length,
                              itemBuilder: (context, index) {
                                final movie = viewModel.movies[index];

                                return _movieTile(context, movie);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _movieTile(BuildContext context, Movie movie) {
    return Padding(
      padding: 8.padY,
      child: Material(
        color: Colors.transparent,
        borderRadius: 10.circularRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            context.push(MovieDetailView(movie));
          },
          child: Ink(
            child: Row(
              children: [
                ImageHolder(movie.posterPath ?? movie.backdropPath),
                16.spaceX,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${movie.title}',
                        overflow: TextOverflow.ellipsis,
                        style: context.style16W500.copyWith(height: 1.25),
                      ),
                      Text(
                        'Genres',
                        style: context.style12W500.copyWith(
                          color: AppColors.lightGrayColor,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz),
                  color: AppColors.buttonColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  SearchMovieViewModel viewModelBuilder(BuildContext context) {
    return SearchMovieViewModel(context);
  }
}
