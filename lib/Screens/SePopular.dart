import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:move_app/Screens/Detalis_Screen.dart';
import 'package:move_app/json/popular_movies.dart';
import 'package:move_app/models/List.dart';
//import 'package:move_app/models/oop.dart';

// class Sepopular extends StatelessWidget {
//   const Sepopular({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return
//        Scaffold(
//         body: Container(height: 100,width: 100 ,color: Colors.red,),
//       )
//     ;
//     // return Container(height: 100,width: 100 ,color: Colors.red,);
//   }
// }

class Sepopular extends StatefulWidget {
  const Sepopular({super.key});

  @override
  State<Sepopular> createState() => _SepopularState();
}

class _SepopularState extends State<Sepopular> {
  @override
  void initState() {
    super.initState();
    funPopuler();
  }

  Future<void> funPopuler() async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/popular?language=en-US&page=2'),
        headers: {
          "accept": "application/json",
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTkxMmIyODYyMzA2YjgwZmU2ZDVlMjliMDczYTMwYSIsIm5iZiI6MTcyMTYxOTcyNS4yMTI1NTMsInN1YiI6IjY2OWRkMTk0MTU3MGVkNDk0ZjE4NjZjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mRvodRF11IftYF4zk7B3xeYGyLhcQlv9jsk34TZtMFs"
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final popularmovies = Popular.fromJson(data);

      setState(() {
        popular_movies_se = popularmovies.results ?? [];
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
                itemCount: popular_movies_se.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final movie = popular_movies_se[index];
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
                              child: Text('Error loading popular data'),
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
                                    movie.name ?? 'No Title',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
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
