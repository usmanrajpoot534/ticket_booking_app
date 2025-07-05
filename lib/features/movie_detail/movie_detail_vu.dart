import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:stacked/stacked.dart';
import 'package:ticket_booking_app/core/constants/app_colors.dart';
import 'package:ticket_booking_app/features/booking/hall_selection_screen.dart';
import 'package:ticket_booking_app/models/movies_record.dart';
import 'package:ticket_booking_app/widgets/button/app_button.dart';
import 'package:ticket_booking_app/widgets/button/app_outlined_button.dart';

import 'movie_detail_vm.dart';

class MovieDetailView extends StackedView<MovieDetailViewModel> {
  final Movie movie;
  const MovieDetailView(this.movie, {super.key});

  @override
  Widget builder(
    BuildContext context,
    MovieDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: context.kHeight * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  movie.posterPath == null && movie.backdropPath == null
                      ? 'https://www.kevingage.com/assets/clapboard.png'
                      : 'https://media.themoviedb.org/t/p/w220_and_h330_face/${movie.posterPath ?? movie.backdropPath}',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
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
                Column(
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: 16.padAll,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: context.pop,
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.white,
                            ),
                            16.spaceX,
                            Text(
                              'Watch',
                              style: context.style16W500.copyWith(
                                color: Colors.white,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(48, 16, 48, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'In Theaters ${movie.releaseDate?.dateFromString.format('MMM d, y')}',
                            textAlign: TextAlign.center,
                            style: context.style16W500.copyWith(
                              color: Colors.white,
                              height: 1.25,
                            ),
                          ),
                          16.spaceY,
                          AppButton(
                            label: 'Get Tickets',
                            onTap: () =>
                                context.push(HallSelectionScreen(movie)),
                          ),
                          12.spaceY,
                          AppOutlinedButton(
                            label: 'Watch Trailer',
                            icon: Icons.play_arrow,
                            loading: viewModel.isBusy,
                            onTap: viewModel.getMovieTrailer,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: 16.padAll,
              color: AppColors.lightGrayColor,
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heading('Genres'),
                  Row(
                    spacing: 8,
                    children: [
                      _genresChip('Action', AppColors.tealColor),
                      _genresChip('Thriller', AppColors.pinkColor),
                      _genresChip('Science', AppColors.purpleColor),
                      _genresChip('Fiction', AppColors.yellowColor),
                    ],
                  ),
                  Divider(),
                  _heading('Overview'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        '${movie.overview}',
                        style: context.style12W400.copyWith(
                          color: Color(0XFF8F8F8F),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heading(String value) {
    return Text(
      value,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.25),
    );
  }

  Widget _genresChip(String label, Color color) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: 16.circularRadius),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  MovieDetailViewModel viewModelBuilder(BuildContext context) {
    return MovieDetailViewModel(context, movie.id);
  }
}
