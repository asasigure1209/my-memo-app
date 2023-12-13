import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key, required this.title});
  final String title;

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0), // 水平方向（左右）に16.0のパディング
                child: QuillEditor.basic(
                  configurations: const QuillEditorConfigurations(
                    readOnly: false,
                  ),
                ),
              )),
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