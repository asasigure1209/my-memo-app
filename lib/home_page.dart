import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_memo_app/database/database.dart';
import 'package:my_memo_app/memo/memo.dart';
import 'package:my_memo_app/memo_page.dart';
import 'package:my_memo_app/constant/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Memo> memos;

  @override
  void initState() {
    super.initState();
  }

  void load() async {
    setState(() {});
  }

  void navigateToMemoPage(Memo memo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemoPage(memo: memo),
      ),
    );

    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Memo>>(
          future: getMemos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            List<Memo> memos = !snapshot.hasData || snapshot.data!.isEmpty
                ? []
                : snapshot.data!;

            return Scaffold(
              body: ListView(
                children: memos
                    .map((memo) => ListTile(
                        title: Text(memo.title,
                            style: const TextStyle(
                                color: AppColors.mainText, fontSize: 20)),
                        subtitle: Text(memo.updatedAt,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.subText,
                            )),
                        onTap: () {
                          navigateToMemoPage(memo);
                        },
                        onLongPress: () {
                          showDeleteConfirmationDialog(context, memo);
                        }))
                    .toList(),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigateToMemoPage(Memo());
                },
                backgroundColor: AppColors.mainText,
                child: const Icon(
                  Icons.add,
                  color: AppColors.mainBackground,
                ),
              ),
            );
          }),
    );
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, Memo memo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('削除の確認'),
          content: const Text('このメモを削除しますか？',
              style: TextStyle(color: AppColors.mainBackground)),
          actions: <Widget>[
            TextButton(
              child: const Text('いいえ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('はい'),
              onPressed: () {
                deleteRecord(memo.id!).then((_) {
                  Navigator.of(context).pop(); // ダイアログを閉じる
                  load();
                }); // データベースからメモを削除
                // ListViewを更新
              },
            ),
          ],
        );
      },
    );
  }
}
