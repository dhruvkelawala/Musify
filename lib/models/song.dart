import 'package:Musify_v3/helpers/utils.dart';

class Song {
  String id;
  String title;
  String subtitle;
  String type;
  String image;

  Song(this.id, this.title, this.type, this.image, this.subtitle);

  Song.fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    title = fixHtmlChars(json["title"] ?? "");
    subtitle = fixHtmlChars(json["subtitle"] ?? "");
    type = json["type"];
    image = imageQuality(json["image"]) ?? "";
  }
}
