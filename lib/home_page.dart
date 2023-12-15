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
    loadMemos();
  }

  void loadMemos() async {
    memos = await getMemos();
    setState(() {});
  }

  void navigateToMemoPage(Memo memo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemoPage(memo: memo),
      ),
    );

    loadMemos(); // ここでsetStateを含むメモリストの再読み込みを行う
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
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('メモがありません');
            }

            return Scaffold(
              body: ListView(
                children: snapshot.data!
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
                        ))
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
}
