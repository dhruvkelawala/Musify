import 'package:flutter/material.dart';
import "./app.dart";
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: false// optional: set false to disable printing logs to console
      );
  runApp(MyApp());
}
