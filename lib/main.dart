import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multiplat/core/util/platform_util.dart';
import 'package:multiplat/locator.dart';
import 'package:multiplat/ui/router.dart';

void main() {
  if (!kIsWeb &&
      (debugDefaultTargetPlatformOverride == null) &&
      !Platform.isAndroid &&
      !Platform.isIOS &&
      !Platform.isMacOS) {
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
    if (isCupertino()) {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'multiplat',
        theme: CupertinoThemeData(
          primaryColor: Colors.blueGrey,
        ),
        initialRoute: 'combined',
        onGenerateRoute: Router.generateRoute,
      );

    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'multiplat',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: !kIsWeb && Platform.isLinux ? 'Roboto' : null,
      ),
      initialRoute: 'combined',
      onGenerateRoute: Router.generateRoute,
    );
  }
}
