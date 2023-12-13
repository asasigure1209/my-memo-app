import 'package:flutter/material.dart';
import 'package:my_memo_app/memo_page.dart';

import 'constant/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyMemo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.mainText),
            bodyMedium: TextStyle(color: AppColors.mainText),
            bodySmall: TextStyle(color: AppColors.mainText)),
        scaffoldBackgroundColor: AppColors.mainBackground,
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.mainBackground,
            titleTextStyle: TextStyle(color: AppColors.mainText, fontSize: 20)),
        useMaterial3: true,
      ),
      home: const SubPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const SubPage(),
        '/subpage': (BuildContext context) =>
            const MemoPage(title: 'Flluter Demo Home Page')
      },
    );
  }
}

class SubPage extends StatelessWidget {
  const SubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigator'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              const Text('Sub'),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed("/subpage"),
                child: const Text('memo'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
