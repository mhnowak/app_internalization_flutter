import 'package:appinternalization/generated/l10n.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter internalization demo",
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(S.of(context).helloWorld),
      )
    );
  }
}