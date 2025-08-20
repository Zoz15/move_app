import 'package:flutter/material.dart';
import 'package:move_app/Screens/Home_Screen.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'json/top_rated_movies.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Results_top_rated> movies = [];
//   bool hasError = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchMovies();
//   }

//   Future<void> fetchMovies() async {
//     final response = await http.get(
//       Uri.parse(
//           'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1'),
//       headers: {
//         "accept": "application/json",
//         "Authorization":
//             "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTkxMmIyODYyMzA2YjgwZmU2ZDVlMjliMDczYTMwYSIsIm5iZiI6MTcyMTYxOTcyNS4yMTI1NTMsInN1YiI6IjY2OWRkMTk0MTU3MGVkNDk0ZjE4NjZjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mRvodRF11IftYF4zk7B3xeYGyLhcQlv9jsk34TZtMFs"
//       },
//     );

//     if (response.statusCode == 200) {
//       print('successful');
//       final data = json.decode(response.body);
//       final topRatedMovies = Movie.fromJson(data);

//       setState(() {
//         movies = topRatedMovies.results ?? [];
//         hasError = false;
//       });
//     } else {
//       print('Error ${response.statusCode}');
//       setState(() {
//         hasError = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData.dark(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Top Rated Movies'),
//         ),
//         body: hasError
//             ? Center(
//                 child: Text('Error loding movies'),
//               )
//             : ListView.builder(
//                 itemCount: movies.length,
//                 itemBuilder: (context, i) {
//                   final movie = movies[i];
//                   return ListTile(
//                     title: Text(movie.title ?? 'No Title'),
//                     subtitle: Flexible(
//                       child: Text(
//                         movie.overview?.substring(0, 50) ?? '',
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     leading: movie.posterPath != null
//                         ? Image.network(
//                             'https://image.tmdb.org/t/p/w500${movie.posterPath}')
//                         : null,
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }
