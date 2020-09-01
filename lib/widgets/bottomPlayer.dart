import 'package:Musify_v3/controllers/player_controller.dart';
import 'package:Musify_v3/models/songDetails.dart';
import 'package:Musify_v3/providers/player_provider.dart';
import 'package:Musify_v3/screens/player.dart';
import 'package:Musify_v3/widgets/position_seek_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class BottomPlayer extends StatelessWidget {
  final PlayerController playerController = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentSong = playerController.currentSong.value;

      print(currentSong);
      if (currentSong == null) {
        return SizedBox(height: 0);
      }

      final SongDetails song = currentSong;

      return GestureDetector(
        onTap: () {
          Get.to(PlayerScreen(song.id));
        },
        child: Container(
          height: 120,
          color: Hexcolor("#181924"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
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
                  child: Text(
                    song.artist,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                trailing: playerController.player.value.builderIsPlaying(
                    builder: (ctx, isPlaying) {
                  return Container(
                    margin: EdgeInsets.only(right: 15, top: 25),
                    child: GestureDetector(
                      onTap: () {
                        playerController.player.value.playOrPause();
                      },
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 30,
                      ),
                    ),
                  );
                }),
              ),
              playerController.player.value.builderRealtimePlayingInfos(
                  builder: (context, infos) {
                if (infos == null) {
                  return SizedBox();
                }

                return Container(
                  child: PositionSeekWidget(
                    height: 2,
                    textSize: 10,
                    thumbSize: 4,
                    currentPosition: infos.currentPosition,
                    duration: infos.duration,
                    seekTo: (to) {
                      playerController.player.value.seek(to);
                    },
                  ),
                );
              })
            ],
          ),
        ),
      );
    });
  }
}
