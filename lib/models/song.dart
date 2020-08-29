import 'package:Musify_v3/helpers/utils.dart';

class Song {
  String id;
  String title;
  String subtitle;
  String type;
  String image;
  String url;
  String artist;

  Song(this.id, this.title, this.type, this.image, this.url, this.artist);

  Song.fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    title = fixHtmlChars(json["title"] ?? "");
    subtitle = fixHtmlChars(json["subtitle"] ?? "");
    type = json["type"];
    image = imageQuality(json["image"]) ?? "";
    url = json["perma_url"];
    artist = fixHtmlChars(json["more_info"]["primary_artists"] ?? "");
  }
}
