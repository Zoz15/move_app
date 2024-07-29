import 'package:flutter/material.dart';

TextStyle kLarg = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);
TextStyle kseeall = const TextStyle(
  fontSize: 12,
  color: Color(0xFFd663d6),
);

Color maincolor = const Color(0xFFd663d6);

TextStyle kLargbold = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(2, 2),
        blurRadius: 3,
        color: Colors.black,
      )
    ]);

TextStyle ksmallbold = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(2, 2),
        blurRadius: 3,
        color: Colors.black,
      )
    ]);
TextStyle ksmallboldnoshadow = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    shadows: <Shadow>[
      // Shadow(
      //   offset:  Offset(2, 2),
      //   blurRadius: 3,
      //   color: Colors.black,
      // )
    ]);

// ignore: must_be_immutable
class PaddingBetwn extends StatelessWidget {
  dynamic onpresed;
  bool isseeall = true;
  String x;
  PaddingBetwn({required this.x, this.isseeall = true, required this.onpresed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            x,
            style: kLarg,
          ),
          InkWell(
            onTap: onpresed,
            child: Text(
              'See all',
              style: kseeall,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Contaner18 extends StatelessWidget {
  String tex;
  Color col;
  Contaner18({super.key, required this.tex, required this.col});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: col,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          tex,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

String runtime(int x) {
  double number = x / 60;
  double roundedNumber = double.parse(number.toStringAsFixed(1));

  String s = '$roundedNumber';
  return s;
}
