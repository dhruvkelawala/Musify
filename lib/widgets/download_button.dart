import 'dart:io';

import 'package:Musify_v3/models/songDetails.dart';
import 'package:des_plugin/des_plugin.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadButton extends StatefulWidget {
  final SongDetails song;

  DownloadButton(this.song);

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  String _localPath;
  String key = "38346591";
  Future<String> _findLocalPath() async {
    final directory = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_MUSIC);
    print(directory);
    return directory;
  }

  Future<bool> _checkPermission() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      print(status);
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(0),
      margin: EdgeInsets.only(left: 7),
      child: MaterialButton(
        onPressed: () async {
          _localPath = (await _findLocalPath());
          print("LOCAL PATH: " + _localPath);
          final savedDir = Directory(_localPath);
          bool hasExisted = await savedDir.exists();
          if (!hasExisted) {
            savedDir.create();
          }
          final perm = await _checkPermission();

          if (perm) {
            final url = await DesPlugin.decrypt(key, widget.song.url);
            print(url);
            final taskId = await FlutterDownloader.enqueue(
                url: url,
                savedDir: _localPath,
                showNotification:
                    true, // show download progress in status bar (for Android)
                openFileFromNotification: true,
                fileName: (widget.song.title +
                    ".mp4") // click on notification to open downloaded file (for Android)
                );
          } else {
            Fluttertoast.showToast(msg: "Please give download Permission");
            await Permission.storage.request();
          }
        },
        shape: CircleBorder(),
        color: HexColor('#F56682'),
        // child: FaIcon(FontAwesomeIcons.download),
        child: Icon(
          Icons.download_sharp,
          color: Colors.black87,
        ),
      ),
    );
  }
}
