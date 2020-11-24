import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './themes/theme.dart';
import './screens/home.dart';
import 'widgets/musify_search.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Musify-V3",
      theme: appTheme,
      routes: {
        // Home.route: (ctx) => Home(),
        MusifySearch.route: (ctx) => MusifySearch(),
      },
      initialRoute: MusifySearch.route,
      debugShowCheckedModeBanner: false,
    );
  }

  

}

// MaterialApp(
//       title: "Musify-V3",
//       theme: appTheme,
//       routes: {
//         // Home.route: (ctx) => Home(),
//         MusifySearch.route: (ctx) => MusifySearch(),
//       },
//       initialRoute: MusifySearch.route,
//       debugShowCheckedModeBanner: false,
//     )
