import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiplat/core/util/platform_util.dart';
import 'package:multiplat/locator.dart';
import 'package:multiplat/ui/router.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (isCupertino()) {
      return const CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'multiplat',
        theme: CupertinoThemeData(
          primaryColor: Colors.blueGrey,
        ),
        initialRoute: 'combined',
        onGenerateRoute: MultiPlatRouter.generateRoute,
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'multiplat',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: 'combined',
      onGenerateRoute: MultiPlatRouter.generateRoute,
    );
  }
}
