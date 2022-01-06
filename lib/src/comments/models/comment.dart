import 'package:comment_section/src/users/models/user.dart';

class Comment {
  final int id;
  final int score;
  final String content;
  final String createdAt;
  final User user;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user,
    this.score = 0,
    this.replies = const []
  });

  Comment.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    content = json['content'],
    createdAt = json['createdAt'],
    score = json['score'],
    replies = (json['replies'] as List).map((e) => Comment.fromJson(e)).toList(),
    user = User.fromJson(json['user']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'createdAt': createdAt,
    'score': score,
    'replies': replies.map((e) => e.toJson()),
    'user': user.toJson()
  };
  
}