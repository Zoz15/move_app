import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:move_app/Screens/Detalis_Screen.dart';
import 'package:move_app/Screens/Home_Screen.dart';
import 'package:move_app/json/search.dart';
import 'package:move_app/models/oop.dart';

class Gotofilesearch extends StatefulWidget {
  final VoidCallback onBack;

  const Gotofilesearch({super.key, required this.onBack});

  @override
  State<Gotofilesearch> createState() => _GotofilesearchState();
}

class _GotofilesearchState extends State<Gotofilesearch> {
  // ignore: non_constant_identifier_names
  List<Results_search> search_movies = [];

  bool isLoading = true;
  bool isError = false;
  String _x2 = '';

  //get http => null;

  @override
  void initState() {
    super.initState();
    searchMovies(x);
  }

  Future<void> searchMovies(String query) async {
    final response = await get(
        Uri.parse(
            "https://api.themoviedb.org/3/search/tv?query=$query&include_adult=false&language=en-US&page=1"),
        headers: {
          "accept": "application/json",
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTkxMmIyODYyMzA2YjgwZmU2ZDVlMjliMDczYTMwYSIsIm5iZiI6MTcyMTgwNDI4OS44MzE5MTksInN1YiI6IjY2OWRkMTk0MTU3MGVkNDk0ZjE4NjZjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6SZrHnItTbHnW34CiSLQF0asdk2CqYBgFvwLtxdgM1I"
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        final searchMovie = SearchResponse.fromJson(data);
        search_movies = searchMovie.results ?? [];
        isLoading = false;
        isError = false;
      });
    } else {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
    print(response.statusCode);
    print('---------------------------------------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('images/image 4.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(.5), BlendMode.darken)),
        ),
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 30, left: 30, top: 30, bottom: 15),
            child: TextField(
              //  The Crown
              onChanged: (value) => _x2 = value,
              decoration: InputDecoration(
                hintText: 'Search of movie',
                prefixIcon: IconButton(
                    onPressed: () {
                      widget.onBack();
                    },
                    icon: const Icon(Icons.home)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  //0000
                  onPressed: () {
                    setState(() {
                      searchMovies(_x2);
                    });
                    //000
                  },
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  searchMovies(value);
                });
                //0000
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : isError
                    ? const Center(child: Text('Error fetching results'))
                    : GridView.builder(
                        itemCount: search_movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Two columns
                          childAspectRatio:
                              2 / 3, // Adjust the aspect ratio as needed
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final movie = search_movies[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetalisScreen(id: movie.id!)));
                            },
                            child: Container(
                              height: 150,
                              width: 100,
                              // margin:
                              //     const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(movie.name ?? 'No Title',
                                        style: ksmallbold),
                                    Text(
                                      movie.firstAirDate ?? 'No Date',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(2, 2),
                                              blurRadius: 3,
                                              color: Colors.black,
                                            )
                                          ]), // Exampl
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          )
        ]),
      ),
    );
  }
}
