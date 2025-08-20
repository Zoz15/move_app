
import 'package:flutter/material.dart';
import 'package:move_app/Screens/Detalis_Screen.dart';
import 'package:move_app/json/on_the_air.dart';

class OnTheAir extends StatelessWidget {
  const OnTheAir({
    super.key,
    required this.on_the_air_movies,
  });

  final List<Results_on_the_air> on_the_air_movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: on_the_air_movies.length,
        itemBuilder: (context, i) {
          final movie = on_the_air_movies[i];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalisScreen(id: movie.id!)));
            },
            child: Container(
              margin: EdgeInsets.all(8),
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
