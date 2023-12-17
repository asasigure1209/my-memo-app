import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:my_memo_app/database/database.dart';
import 'package:my_memo_app/memo/memo.dart';

class MemoPage extends StatefulWidget {
  final Memo memo;
  const MemoPage({super.key, required this.memo});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    String title = widget.memo.title;

    if (widget.memo.content != null) {
      _controller.document =
          Document.fromJson(jsonDecode(widget.memo.content!));
    }

    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'メモを保存',
            onPressed: () {
              if (widget.memo.id == null) {
                insertMemo(Memo(
                    title: title,
                    content:
                        jsonEncode(_controller.document.toDelta().toJson())));
              } else {
                updateRecord(Memo(
                    id: widget.memo.id,
                    title: title,
                    createdAt: widget.memo.createdAt,
                    content:
                        jsonEncode(_controller.document.toDelta().toJson())));
              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('メモを保存しました')));
            },
          ),
        ]),
        body: QuillProvider(
          configurations: QuillConfigurations(
            controller: _controller,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('ja'),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: TextField(
                              controller: TextEditingController(
                                  text: widget.memo.title),
                              onChanged: (value) {
                                title = value;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                fontSize: 24,
                              )),
                        ),
                        QuillEditor.basic(
                          configurations: const QuillEditorConfigurations(
                            readOnly: false,
                          ),
                        )
                      ])))),
              KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.only(
                          bottom: isKeyboardVisible
                              ? MediaQuery.of(context).viewInsets.bottom
                              : 0),
                      child: QuillToolbar(
                        configurations: toolbarConfigurations(),
                      ));
                },
              )
            ],
          ),
        ));
  }

  QuillToolbarConfigurations toolbarConfigurations() {
    return const QuillToolbarConfigurations(
        toolbarIconAlignment: WrapAlignment.spaceAround,
        showAlignmentButtons: false,
        showBackgroundColorButton: false,
        showBoldButton: false,
        showCenterAlignment: false,
        showClearFormat: false,
        showCodeBlock: false,
        showColorButton: false,
        showDirection: false,
        showDividers: false,
        showFontFamily: false,
        showFontSize: false,
        showHeaderStyle: false,
        showIndent: false,
        showInlineCode: false,
        showItalicButton: false,
        showJustifyAlignment: false,
        showLeftAlignment: false,
        showLink: false,
        showListBullets: true,
        showListCheck: true,
        showListNumbers: true,
        showQuote: false,
        showRedo: true,
        showRightAlignment: false,
        showSearchButton: false,
        showSmallButton: false,
        showStrikeThrough: false,
        showSubscript: false,
        showSuperscript: false,
        showUnderLineButton: false,
        showUndo: true);
  }
}
