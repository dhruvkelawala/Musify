import 'package:Musify_v3/models/song.dart';
import 'package:flutter/foundation.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PlayerProvider extends ChangeNotifier {
  AssetsAudioPlayer _player = AssetsAudioPlayer();

  AssetsAudioPlayer get player => _player;

  void playTitles(Song song) {
    AssetsAudioPlayer.playAndForget(Audio.network(song.url));
  }

  void openAndPlay(Song song) {
    _player.open(Audio.network(song.url));
  }

  
}
