import 'package:flutter/material.dart';
import 'package:my_memo_app/database/database.dart';
import 'package:my_memo_app/memo/memo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_memo_app/memo_page.dart';

import 'constant/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database db = await initializeDB();

  List<Memo> memos = await getMemos(db);

  runApp(MyApp(memos: memos));
}

class MyApp extends StatelessWidget {
  final List<Memo> memos;
  const MyApp({super.key, required this.memos});

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
