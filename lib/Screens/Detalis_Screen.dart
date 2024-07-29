import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:move_app/Screens/Home_Screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'package:move_app/json/details.dart';
import 'package:move_app/models/oop.dart'; // Adjust the import path as needed

class DetalisScreen extends StatefulWidget {
  final int id;
  DetalisScreen({required this.id});

  @override
  State<DetalisScreen> createState() => _DetalisScreenState();
}

class _DetalisScreenState extends State<DetalisScreen> {
  late Future<Details> detailsFuture;

  @override
  void initState() {
    super.initState();
    detailsFuture = fetchDetails();
  }

  Future<Details> fetchDetails() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/${widget.id}?language=en-US'),
      headers: {
        "accept": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTkxMmIyODYyMzA2YjgwZmU2ZDVlMjliMDczYTMwYSIsIm5iZiI6MTcyMTcxMzU3MC44MzAyNiwic3ViIjoiNjY5ZGQxOTQxNTcwZWQ0OTRmMTg2NmNlIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9._15T-eaOSryTsQymIjXMrZeXHhaH9nEeIZp-uat8CsI"
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Details.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: FutureBuilder<Details>(
          future: detailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final details = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${details.posterPath}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30, right: 10, left: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()));
                                    });
                                  },
                                  icon: Icon(Icons.arrow_back)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  //width: 200,
                                  //height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFd663d6),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15),
                                      child: Text(
                                        'POPULAR ${(details.popularity?.toInt()).toString()}',
                                        style: ksmallboldnoshadow,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 25,
                                        color: Colors.orange,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, 0),
                                            color: Colors.black,
                                            blurRadius: 20,
                                          )
                                        ],
                                      ),
                                      Text(
                                        '${details.voteAverage?.toStringAsFixed(1)}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0, 0),
                                              color: Colors.black,
                                              blurRadius: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      details.adult!
                                          ? Contaner18(
                                              tex: '+18', col: Colors.red)
                                          : Contaner18(
                                              tex: '-18', col: Colors.green)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      child: InkWell(
                        onTap: () async {
                          final url = Uri.parse(
                              details.homepage!); // Replace with your URL
                          launchUrl(url);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFd663d6),
                          ),
                          child: const Center(
                            child: Text(
                              'PAGE OF MOVE',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 20),
                      child: Text(
                        details.title ?? 'No title',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          Text(
                            '  ${details.releaseDate ?? 'N/A'}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '${runtime(details.runtime!)} hour/s',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${details.originalTitle}'),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            details.overview ?? 'No overview available',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('ID : ${details.id}'),
                          Text(
                            'Genres Move :\n ${details.genres ?? 'N/A'}',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //height: 500,
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          Text(
                            'cover photo',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          details.backdropPath == null
                              ? const Center(
                                  child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage('images/sad.png'),
                                        height: 100,
                                        width: 100,
                                      ),
                                      Text('        No Cover Photo'),
                                    ],
                                  ),
                                ))
                              : Image(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500${details.backdropPath}'),
                                  fit: BoxFit.contain),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
