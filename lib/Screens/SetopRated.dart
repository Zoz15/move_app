import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:move_app/Screens/Detalis_Screen.dart';
import 'package:move_app/json/top_rated_movies.dart';
import 'package:move_app/models/List.dart';


class Setop extends StatefulWidget { //dd
  const Setop({super.key});

  @override
  State<Setop> createState() => _SetopState();
}

class _SetopState extends State<Setop> {
  @override
  void initState() {
    super.initState();
    funTop();
  }

  Future<void> funTop() async { //dd
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=2'),
      headers: {
        "accept": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTkxMmIyODYyMzA2YjgwZmU2ZDVlMjliMDczYTMwYSIsIm5iZiI6MTcyMTYxOTcyNS4yMTI1NTMsInN1YiI6IjY2OWRkMTk0MTU3MGVkNDk0ZjE4NjZjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mRvodRF11IftYF4zk7B3xeYGyLhcQlv9jsk34TZtMFs"
      },
    );

    if (response.statusCode == 200) {
      print('successful');
      final data = json.decode(response.body);
      final topRatedMovies = Movie.fromJson(data); //dd
      setState(() {
        top_rated_movies_se = topRatedMovies.results ?? [];  //dd
      });
    } else {
      print(response.statusCode);
      print('---------------------------------------------------');
      setState(() {
        isError5 = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: GridView.builder(
                itemCount: top_rated_movies_se.length, //dd
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final movie = top_rated_movies_se[index];  // dd
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalisScreen(id: movie.id!),
                        ),
                      );
                    },
                    child: isError5
                        ? const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Error loading Top Rate data'),
                            ),
                          )
                        : Container(
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
                                  Text(
                                    movie.title ?? 'No Title',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    movie.releaseDate ?? 'No Date',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 3,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.withOpacity(.5)),
                  child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
