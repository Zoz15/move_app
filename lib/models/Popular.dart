import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:move_app/Screens/Detalis_Screen.dart';
import 'package:move_app/json/popular_movies.dart';
import 'package:move_app/models/oop.dart';

class PopularIs extends StatelessWidget {
  const PopularIs({
    super.key,
    // ignore: non_constant_identifier_names
    required this.popular_movies,
  });

  // ignore: non_constant_identifier_names
  final List<Results_popular> popular_movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enlargeCenterPage: true,
        ),
        items: popular_movies.map((movie) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetalisScreen(id: movie.id!)));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.name?.toUpperCase() ?? 'No Title',
                            style: kLargbold,
                          ),
                          Text(
                            movie.firstAirDate?.toUpperCase() ?? 'No Date',
                            style: const TextStyle(
                              color: Colors.white,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 3,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
