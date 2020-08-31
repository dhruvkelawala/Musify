import 'package:Musify_v3/models/songDetails.dart';
import 'package:des_plugin/des_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

String key = "38346591";

class PlayerProvider extends ChangeNotifier {
  AssetsAudioPlayer _player = AssetsAudioPlayer();
  SongDetails _currentSong;

  AssetsAudioPlayer get getPlayer => _player;

  SongDetails get getCurrentSong => _currentSong;

  set setCurrentSong(SongDetails song) {
    _currentSong = song;
    notifyListeners();
  }

  void playTitles(SongDetails song) {
    AssetsAudioPlayer.playAndForget(Audio.network(song.url));
  }

  Future<void> openAndPlay(SongDetails song) async {
    _currentSong = song;
    final url = await DesPlugin.decrypt(key, song.url);

    _player.open(
        Audio.network(url,
            metas: Metas(
                artist: song.artist,
                title: song.title,
                image: MetasImage.network(song.image))),
        showNotification: true,
        autoStart: true,
        notificationSettings: NotificationSettings(
          nextEnabled: false,
          prevEnabled: false,
        ));
  }

  notifyListeners();
}
