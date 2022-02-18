import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const <Widget>[
          Icon(
            Icons.library_music_outlined,
            size: 170.0,
            color: Color(0xff1c62ed),
          )
        ],
      ),
    );
  }
}
