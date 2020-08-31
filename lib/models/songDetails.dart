import 'package:Musify_v3/helpers/utils.dart';
import "package:des_plugin/des_plugin.dart";

class SongDetails {
  String id;
  String title;
  String type;
  String image;
  String url;
  String artist;

  SongDetails(
      this.id, this.title, this.type, this.image, this.url, this.artist);

  SongDetails.fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    title = fixHtmlChars(json["song"] ?? "");
    type = json["type"] ?? "";
    image = imageQuality(json["image"]) ?? "";
    url = json["encrypted_media_url"];
    artist = fixHtmlChars(
      json["primary_artists"] ?? (json["singers"] ?? ""),
    );
  }
}
