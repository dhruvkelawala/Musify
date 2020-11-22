import 'package:Musify_v3/models/song.dart';
import 'package:Musify_v3/screens/player.dart';
import 'package:Musify_v3/services/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import "package:flutter/material.dart";
import "package:flappy_search_bar/flappy_search_bar.dart";
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'bottomPlayer.dart';
import 'top_songs.dart';

class MusifySearch extends StatelessWidget {
  static final route = '/musify-search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomPlayer(),
      // appBar: PreferredSize(
      //   preferredSize:
      //       Size.fromHeight(90 + MediaQuery.of(context).viewPadding.top),
      //   child: Container(
      //     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
      //     color: Theme.of(context).backgroundColor,
      //     child: Row(
      //       // padding: EdgeInsets.only(left: 10),
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [Image.asset('assets/FG.png', height: 70)],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: Image.asset('assets/FG.png', height: 70),
        title: Text("Musify", style: TextStyle(fontSize: 32),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SearchBar(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
          loader: SearchLoader(),
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
        onTap: () {
          Get.to(PlayerScreen(song.id));
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => PlayerScreen(song.id)));
        },
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(song.image),
          radius: 28,
          // child: Image(
          //   image: CachedNetworkImageProvider(song.image),
          //   fit: BoxFit.cover,
          // ),
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
          child: Text(song.subtitle),
        ),
      ),
    );
  }
}

class SearchLoader extends StatelessWidget {
  const SearchLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
