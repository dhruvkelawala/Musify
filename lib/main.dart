import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:workmanager/workmanager.dart';
import "./app.dart";
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final int helloAlarmID = 0;
  await AndroidAlarmManager.initialize();
  await FlutterDownloader.initialize(
      debug: false // optional: set false to disable printing logs to console
      );

  // FlutterBackgroundService.initialize(onStart);
  // Workmanager.initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode:
  //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  //     );
  // Workmanager.registerOneOffTask("1", "simpleTask");

  runApp(MyApp());
  await AndroidAlarmManager.periodic(
      const Duration(seconds: 5), helloAlarmID, printHello);
}

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

// void callbackDispatcher() {
//   Workmanager.executeTask((task, inputData) {
//     print(
//         "Native called background task: $task"); //simpleTask will be emitted here.
//     return Future.value(true);
//   });
// }

// void onStart() {
//   WidgetsFlutterBinding.ensureInitialized();
//   final service = FlutterBackgroundService();
//   service.onDataReceived.listen((event) {
//     if (event["action"] == "setAsForeground") {
//       service.setForegroundMode(true);
//       return;
//     }

//     if (event["action"] == "setAsBackground") {
//       service.setForegroundMode(false);
//     }

//     if (event["action"] == "stopService") {
//       service.stopBackgroundService();
//     }
//   });

//   // bring to foreground
//   service.setForegroundMode(true);

//   Timer.periodic(Duration(seconds: 1), (timer) async {
//     if (!(await service.isServiceRunning())) timer.cancel();
//     service.setNotificationInfo(
//       title: "My App Service",
//       content: "Updated at ${DateTime.now()}",
//     );

//     service.sendData(
//       {"current_date": DateTime.now().toIso8601String()},
//     );
//   });
// }
