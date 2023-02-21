import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieapp_appgain/utils/colors.dart';
import '/models/popular_movies_model.dart';
import 'movie_list_item.dart';


class CustomListViewWidget extends StatelessWidget {
  const CustomListViewWidget({
    Key? key,
    required this.popularMoviesList,
  }) : super(key: key);

  final List<PopularMovies> popularMoviesList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shrinkWrap: true,
      itemBuilder: (context, index) => MovieListItem(movie: popularMoviesList[index]),
      separatorBuilder: (context, index) => SizedBox(),
      itemCount: popularMoviesList.length,
    );
  }
}
