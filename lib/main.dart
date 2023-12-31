import 'package:flutter/material.dart';
import 'package:my_memo_app/database/database.dart';
import 'package:my_memo_app/home_page.dart';
import 'package:my_memo_app/constant/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDB();

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
            titleTextStyle: TextStyle(color: AppColors.mainText, fontSize: 20),
            iconTheme: IconThemeData(color: AppColors.mainText)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
