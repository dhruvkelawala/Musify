import 'package:Musify_v3/models/song.dart';
import 'package:Musify_v3/services/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import "package:flutter/material.dart";
import "package:flappy_search_bar/flappy_search_bar.dart";
import 'package:shimmer/shimmer.dart';

import 'top_songs.dart';

class MusifySearch extends StatelessWidget {
  static final route = '/musify-search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar(
          searchBarPadding:
              EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          hintText: "Search",
          hintStyle: TextStyle(fontSize: 17),
          textStyle: TextStyle(color: Colors.white),
          icon: Container(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
          searchBarStyle: SearchBarStyle(
            borderRadius: BorderRadius.circular(40),
          ),
          onSearch: (query) => searchSong(query),
          onItemFound: (dynamic song, int index) => buildItemTile(song),
          onError: (error) {
            return Center(child: Text(error.toString()));
          },
          cancellationWidget: Icon(Icons.cancel),
          placeHolder: buildPlaceholder(),
          loader: Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPlaceholder() {
    return Column(
      children: [
        // MusifySearch(),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 20, bottom: 15, top: 15),
          child: Text("Trending Today",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        ),
        TopSongs(),
      ],
    );
  }

  Widget buildItemTile(Song song) {
    return Container(
      child: ListTile(
        // leading: Container(
        //   child: CachedNetworkImage(
        //       imageUrl: song.image,
        //       placeholder: (ctx, image) {
        //         return Shimmer.fromColors(
        //           baseColor: Colors.black,
        //           highlightColor: Colors.grey[800],
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(15),
        //             child: Container(
        //               color: Colors.black,
        //             ),
        //           ),
        //         );
        //       }),
        // ),
        leading: Image(
          image: CachedNetworkImageProvider(
           song.image
          ),
          fit: BoxFit.cover,
        ),
        title: Container(
          child: Text(
            song.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Container(
          child: Text(song.artist),
        ),
      ),
    );
  }
}
