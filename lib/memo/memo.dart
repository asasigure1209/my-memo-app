import 'package:intl/intl.dart';

class Memo {
  final int? id;
  final String title;
  final String updatedAt;
  final String createdAt;
  final String? content;

  Memo(
      {this.id,
      this.title = "新規作成",
      String? updatedAt,
      String? createdAt,
      this.content})
      : updatedAt = updatedAt ??
            DateFormat('yyyy/MM/dd HH:mm').format(DateTime.now().toLocal()),
        createdAt = createdAt ??
            DateFormat('yyyy/MM/dd HH:mm').format(DateTime.now().toLocal());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'content': content,
    };
  }

  // fromMapメソッドも必要に応じて定義
}
