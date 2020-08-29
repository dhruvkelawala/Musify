import 'package:Musify_v3/models/song.dart';
import 'package:Musify_v3/screens/player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../services/api.dart';
import "package:flutter/material.dart";

//  height: MediaQuery.of(context).size.height * 0.3,

class TopSongs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getTopSongs(),
        initialData: {},
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      Song song = snapshot.data[index];

                      return songCards(
                        context: context,
                        index: index,
                        song: song,
                      );
                    },
                    itemCount: 15,
                  ),
                )
              : loadingShimmer(context);
        },
      ),
    );
  }

  Container loadingShimmer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin:
                  EdgeInsets.only(right: 4, left: index == 0 ? 18 : 4, top: 4),
              width: 200,
              child: Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: Colors.grey[800],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget songCards(
      {@required BuildContext context,
      @required int index,
      @required Song song}) {
    return Container(
      margin: EdgeInsets.only(right: 4, left: index == 0 ? 18 : 4, top: 4),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PlayerScreen(song)));
            },
            child: Container(
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: song.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10, left:20),
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              song.title,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize:17),
            ),
          )
        ],
      ),
    );
  }
}
