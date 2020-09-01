import 'package:Musify_v3/models/songDetails.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:des_plugin/des_plugin.dart';
import 'package:get/get.dart';

String key = "38346591";

class PlayerController extends GetxController {
  var player = AssetsAudioPlayer().obs;
  Rx<SongDetails> currentSong = Rx<SongDetails>();

  // AssetsAudioPlayer get getPlayer => _player;

  // SongDetails get getCurrentSong => _currentSong;

  set setCurrentSong(SongDetails song) {
    currentSong.value = song;
  }

  void playTitles(SongDetails song) {
    AssetsAudioPlayer.playAndForget(Audio.network(song.url));
  }

  Future<void> openAndPlay(SongDetails song) async {
    currentSong.value = song;
    final url = await DesPlugin.decrypt(key, song.url);
    player.value.open(
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
}
