import 'package:Musify_v3/controllers/player_controller.dart';
import 'package:Musify_v3/models/songDetails.dart';
import 'package:Musify_v3/services/api.dart';
import 'package:Musify_v3/widgets/position_seek_widget.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/download_button.dart';

class PlayerScreen extends StatefulWidget {
  final String songId;
  PlayerScreen(this.songId);
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final PlayerController player = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Obx(() {
          if (player.currentSong.value == null) {
            return futureFetchSongDetails();
          }
          return widget.songId == player.currentSong.value.id
              ? Column(
                  children: [
                    songPoster(player.currentSong.value.image),
                    songArtists(player.currentSong.value.artist),
                    songTitle(player.currentSong.value.title),
                    songPlayer(player.currentSong.value)
                  ],
                )
              : futureFetchSongDetails();
        }));
  }

  Widget futureFetchSongDetails() {
    return FutureBuilder(
      future: fetchSongDetail(widget.songId),
      initialData: {},
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    songPoster(snapshot.data.image),
                    songArtists(snapshot.data.artist),
                    songTitle(snapshot.data.title),
                    songPlayer(snapshot.data)
                  ],
                ),
              )
            : Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              );
      },
    );
  }

  Widget songPlayer(SongDetails song) {
    return Obx(() {
      if (player.currentSong.value != null) {
        if (song.id != player.currentSong.value.id) {
          print("Not null");
          player.openAndPlay(song);
        }
      } else {
        player.openAndPlay(song);
      }
      print(player.currentSong.value);

      final newPlayer = player.player.value;

      return newPlayer.builderRealtimePlayingInfos(builder: (context, infos) {
        if (infos == null) {
          return SizedBox();
        }
        return Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.055),
          child: Column(
            children: [
              PositionSeekWidget(
                currentPosition: infos.currentPosition,
                duration: infos.duration,
                seekTo: (to) {
                  newPlayer.seek(to);
                },
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DownloadButton(song),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        fastRewindButton(newPlayer),
                        playButton(newPlayer),
                        fastForwardButton(newPlayer),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      });
    });
  }

  Container fastForwardButton(AssetsAudioPlayer newPlayer) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: GestureDetector(
        onTap: () {
          newPlayer.seekBy(Duration(seconds: 10));
        },
        child: Icon(
          Icons.fast_forward,
          size: 40,
        ),
      ),
    );
  }

  Container fastRewindButton(AssetsAudioPlayer newPlayer) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {
          newPlayer.seekBy(Duration(seconds: -10));
        },
        onLongPress: () {
          newPlayer.seek(Duration(minutes: 0, seconds: 0));
        },
        child: Icon(
          Icons.fast_rewind,
          size: 40,
        ),
      ),
    );
  }

  Widget playButton(AssetsAudioPlayer player) {
    return player.builderIsPlaying(builder: (ctx, isPlaying) {
      return Container(
        child: GestureDetector(
          onTap: () {
            player.playOrPause();
          },
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 70,
          ),
        ),
      );
    });
  }

  Widget songTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget songArtists(String artists) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30),
      child: Text(
        artists,
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget songPoster(String image) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          colors: [Colors.black, Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        child: CachedNetworkImage(
          imageUrl: image,
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
