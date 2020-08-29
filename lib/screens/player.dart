import 'package:Musify_v3/models/song.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;
  PlayerScreen(this.song);
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            songPoster(),
            // songArtist(),
            songTitle(),
          ],
        ),
      ),
    );
  }

  Widget songTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30),
      child: Text(
        widget.song.title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget songPoster() {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        height: 600,
        child: CachedNetworkImage(
          imageUrl: widget.song.image,
          fit: BoxFit.cover,
        ),
      ),
    );
    // return Stack(
    //   children: [
    //     Container(
    //       height: 600,
    //       child: CachedNetworkImage(
    //         imageUrl: widget.song.image,
    //         color: Color.fromRGBO(255, 255, 255, 0.25),
    //         colorBlendMode: BlendMode.modulate,
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ],
    // );
  }
}
