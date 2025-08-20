// ignore: file_names
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:move_app/Screens/SePopular.dart';
import 'package:move_app/Screens/Seon.dart';
import 'package:move_app/Screens/SetopRated.dart';
import 'package:move_app/json/airing_today.dart';
import 'package:move_app/json/on_the_air.dart';
import 'package:move_app/json/top_rated_movies.dart';
import 'package:move_app/models/List.dart';
import 'package:move_app/models/Popular.dart';
import 'package:move_app/Screens/Search_Screen.dart';
import 'package:move_app/models/airingtoday.dart';
import 'package:move_app/models/ontheair.dart';
import 'package:move_app/models/oop.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:move_app/json/popular_movies.dart';
import 'package:move_app/models/toprated.dart';

String x = 'Breaking Bad';
bool issearch = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    funPopuler();
    funTopRated();
    funONTheAir();
    funAiringToday();
  }

  int _page = 0;

  //? get data form api ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
  //! start point

  Future<void> funPopuler() async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/popular?language=en-US&page=1'),
        headers: {
          "accept": "application/json",
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTkxMmIyODYyMzA2YjgwZmU2ZDVlMjliMDczYTMwYSIsIm5iZiI6MTcyMTYxOTcyNS4yMTI1NTMsInN1YiI6IjY2OWRkMTk0MTU3MGVkNDk0ZjE4NjZjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mRvodRF11IftYF4zk7B3xeYGyLhcQlv9jsk34TZtMFs"
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final popularmovies = Popular.fromJson(data);

      setState(() {
        popular_movies = popularmovies.results ?? [];
        // isError = false;
      });
    } else {
      print(response.statusCode);
      print('---------------------------------------------------');
      setState(() {
        isError = true;
      });
    }
  }

  Future<void> funTopRated() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1'),
      headers: {
        "accept": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTkxMmIyODYyMzA2YjgwZmU2ZDVlMjliMDczYTMwYSIsIm5iZiI6MTcyMTYxOTcyNS4yMTI1NTMsInN1YiI6IjY2OWRkMTk0MTU3MGVkNDk0ZjE4NjZjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mRvodRF11IftYF4zk7B3xeYGyLhcQlv9jsk34TZtMFs"
      },
    );

    if (response.statusCode == 200) {
      print('successful');
      final data = json.decode(response.body);
      final topRatedMovies = Movie.fromJson(data);

      setState(() {
        top_rated_movies = topRatedMovies.results ?? [];
        isError2 = false;
      });
    } else {
      print('Error ${response.statusCode}');
      setState(() {
        isError2 = true;
      });
    }
  }

  Future<void> funONTheAir() async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/on_the_air?language=en-US&page=1'),
        headers: {
          "accept": "application/json",
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTkxMmIyODYyMzA2YjgwZmU2ZDVlMjliMDczYTMwYSIsIm5iZiI6MTcyMTYxOTcyNS4yMTI1NTMsInN1YiI6IjY2OWRkMTk0MTU3MGVkNDk0ZjE4NjZjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mRvodRF11IftYF4zk7B3xeYGyLhcQlv9jsk34TZtMFs"
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final ontheair = On_the_air.fromJson(data);
      setState(() {
        on_the_air_movies = ontheair.results ?? [];
        isError3 = false;
      });
    } else {
      print('Error ${response.statusCode}');
      setState(() {
        isError3 = true;
      });
    }
  }

  Future<void> funAiringToday() async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/airing_today?language=en-US&page=1'),
        headers: {
          "accept": "application/json",
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTkxMmIyODYyMzA2YjgwZmU2ZDVlMjliMDczYTMwYSIsIm5iZiI6MTcyMTYxOTcyNS4yMTI1NTMsInN1YiI6IjY2OWRkMTk0MTU3MGVkNDk0ZjE4NjZjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mRvodRF11IftYF4zk7B3xeYGyLhcQlv9jsk34TZtMFs"
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final airingtoday = Airing_today.fromJson(data);
      setState(() {
        airing_today_movies = airingtoday.results ?? [];
        isError4 = false;
      });
    } else {
      print('Error ${response.statusCode}');
      setState(() {
        isError4 = true;
      });
    }
  }

  //! end point

  void _goToHome() {
    setState(() {
      issearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return issearch
        ? Gotofilesearch(onBack: _goToHome)
        : Scaffold(
            //backgroundColor: Color(0xFF424242),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: const Color(0xFF121212),
              color: maincolor,
              items: const [
                Icon(
                  Icons.home,
                  size: 30,
                ),
                Icon(
                  Icons.settings,
                  size: 30,
                ),
              ],
              onTap: (value) {
                setState(() {
                  _page = value;
                });
              },
            ),
            body: _page == 1
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/image 100.jpeg'),
                          fit: BoxFit.cover),
                    ),
                  )
                : SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 30, left: 30, top: 30, bottom: 15),
                            child: TextField(
                              //  The Crown
                              onChanged: (value) => x = value,
                              decoration: InputDecoration(
                                hintText: 'Search of movie',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  //0000
                                  onPressed: () {
                                    setState(() {
                                      issearch = true;
                                    });
                                    //000
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onSubmitted: (value) {
                                //    000
                                setState(() {
                                  x = value;
                                  issearch = true;
                                });
                                //0000
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: Text(
                              'Upcoming Trailers',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold), // Example style
                            ),
                          ),
                          isError
                              ? const SizedBox(
                                  height: 200,
                                  child: Text('Error loading popular data'))
                              : PopularIs(popular_movies: popular_movies),
                       
                          PaddingBetwn(
                              x: 'Pupular',
                              onpresed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Sepopular()));
                              }),
                          TopRated(top_rated_movies: top_rated_movies),
                          PaddingBetwn(
                              x: 'Top Rated',
                              onpresed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Setop()));
                              }),
                          OnTheAir(on_the_air_movies: on_the_air_movies),
                          PaddingBetwn(
                              x: 'On The Air',
                              onpresed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Seon()));
                              }),
                          AiringToday(airing_today_movies: airing_today_movies)
                        ],
                      ),
                    ),
                  ),
          );
  }
}
