class Memo {
  final int? id;
  final String title;
  final String updatedAt;
  final String createdAt;
  final String content;

  Memo(
      {this.id,
      required this.title,
      required this.updatedAt,
      required this.createdAt,
      required this.content});

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
