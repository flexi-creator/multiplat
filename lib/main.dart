import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multiplat/locator.dart';
import 'package:multiplat/ui/router.dart';

void main() {
  if (!kIsWeb && (debugDefaultTargetPlatformOverride == null) && !Platform.isAndroid && !Platform.isIOS && !Platform.isMacOS) {
    print('is platform windows? ${Platform.isWindows}');
    print('is platform linux? ${Platform.isLinux}');
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'multiplat',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
        fontFamily: !kIsWeb && Platform.isLinux ? 'Roboto' : null,
      ),
      initialRoute: 'combined',
      onGenerateRoute: Router.generateRoute,
    );
  }
}
