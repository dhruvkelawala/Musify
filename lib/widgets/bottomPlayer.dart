import 'package:Musify_v3/models/songDetails.dart';
import 'package:Musify_v3/providers/player_provider.dart';
import 'package:Musify_v3/widgets/position_seek_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class BottomPlayer extends StatefulWidget {
  @override
  _BottomPlayerState createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx) {
      final player = Provider.of<PlayerProvider>(context);

      print(player.getCurrentSong);
      if (player.getCurrentSong == null) {
        return SizedBox(height: 0);
      }

      final SongDetails song = player.getCurrentSong;

      return Container(
        height: 80,
        color: Hexcolor("#181924"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: Image(
                image: CachedNetworkImageProvider(song.image),
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
                child: Text(
                  song.artist,
                  style: TextStyle(
                    color: Theme.of(ctx).primaryColor,
                  ),
                ),
              ),
            ),
            // player.getPlayer.builderRealtimePlayingInfos(
            //     builder: (context, infos) {
            //   if (infos == null) {
            //     return SizedBox();
            //   }

            //   return Container(
            //     child: PositionSeekWidget(
            //       currentPosition: infos.currentPosition,
            //       duration: infos.duration,
            //       seekTo: (to) {
            //         player.getPlayer.seek(to);
            //       },
            //     ),
            //   );
            // })
          ],
        ),
      );
    });
  }
}
