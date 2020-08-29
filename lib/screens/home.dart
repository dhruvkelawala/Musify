import 'package:Musify_v3/widgets/musify_search.dart';

import '../widgets/top_songs.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static final route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // MusifySearch(),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20, bottom: 15, top: 15),
                child: Text("Trending Today",
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              ),
              TopSongs(),
            ],
          ),
        ),
      ),
    );
  }
}
