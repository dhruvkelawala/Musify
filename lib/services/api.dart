import 'dart:convert';

import 'package:Musify_v3/models/songDetails.dart';

import '../models/song.dart';
import 'package:Musify_v3/models/song.dart';
import "package:dio/dio.dart";
import 'package:dio_http_cache/dio_http_cache.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: "https://www.jiosaavn.com",
    headers: {"contentType": "application/json"},
  ),
)..interceptors.add(DioCacheManager(
    CacheConfig(
      baseUrl: "https://www.jiosaavn.com",
      defaultMaxAge: Duration(days: 7),
    ),
  ).interceptor);

Future<List> getTopSongs() async {
  final Response resp = await dio.get(
      "/api.php?__call=webapi.get&token=8MT-LQlP35c_&type=playlist&p=1&n=20&includeMetaTags=0&ctx=web6dot0&api_version=4&_format=json&_marker=0");

  // print(resp.data);

  final data = json.decode(resp.data);

  return data["list"].map((song) => Song.fromJSON(song)).toList();
}

Future<List> searchSong(String query) async {
  String searchUrl =
      "/api.php?__call=autocomplete.get&query=$query&_format=json&_marker=0&ctx=web6dot0";
  final Response resp = await dio.get(searchUrl);

  final data = jsonDecode(resp.data);
  print(data["songs"]["data"]);

  return data["songs"]['data'].map((song) => Song.fromJSON(song)).toList();
}

Future<SongDetails> fetchSongDetail(String songId) async {
  String searchUrl =
      "/api.php?cc=in&_marker=0%3F_marker%3D0&_format=json&__call=song.getDetails&pids=$songId";

  final Response resp = await dio.get(searchUrl);

  final data = jsonDecode(resp.data);

  print(data[songId]);

  return SongDetails.fromJSON(data[songId]);
}
