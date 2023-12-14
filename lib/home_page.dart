import 'package:flutter/material.dart';
import 'package:my_memo_app/database/database.dart';
import 'package:my_memo_app/memo/memo.dart';
import 'package:my_memo_app/memo_page.dart';
import 'package:my_memo_app/constant/app_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Memo>>(
        future: getMemos(), // ここでsqfliteからメモのリストを取得
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('メモがありません');
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              Memo memo = snapshot.data![index];
              return ListTile(
                title: Text(memo.title,
                    style: const TextStyle(
                        color: AppColors.mainText, fontSize: 20)),
                subtitle: Text(memo.updatedAt,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.subText,
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemoPage(memo: memo),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      // メモ追加ボタンなどのUIもここに追加
    );
  }
}
