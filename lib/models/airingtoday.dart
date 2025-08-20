import 'package:flutter/material.dart';
import 'package:move_app/Screens/Detalis_Screen.dart';
import 'package:move_app/json/airing_today.dart';

class AiringToday extends StatelessWidget {
  const AiringToday({
    super.key,
    // ignore: non_constant_identifier_names
    required this.airing_today_movies,
  });

  // ignore: non_constant_identifier_names
  final List<Results_airing_today> airing_today_movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: airing_today_movies.length,
        itemBuilder: (context, i) {
          final movie = airing_today_movies[i];
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
