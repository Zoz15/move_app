
import 'package:flutter/material.dart';
import 'package:move_app/Screens/Detalis_Screen.dart';
import 'package:move_app/json/top_rated_movies.dart';

class TopRated extends StatelessWidget {
  const TopRated({
    super.key,
    // ignore: non_constant_identifier_names
    required this.top_rated_movies,
  });

  // ignore: non_constant_identifier_names
  final List<Results_top_rated> top_rated_movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: top_rated_movies.length,
        itemBuilder: (context, i) {
          final movie = top_rated_movies[i];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalisScreen(id: movie.id!)));
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              width: 150,
              decoration: BoxDecoration(
                image: movie.posterPath != null
                    ? DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                        fit: BoxFit.cover)
                    : null,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          );
        },
      ),
    );
  }
}
