

import 'package:flutter/material.dart';

class IsError extends StatelessWidget {
  const IsError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        children: [
          Image(image: AssetImage('images/sad.png',),),
          Text('Error fetching results'),
        ],
      )
      );
  }
}
