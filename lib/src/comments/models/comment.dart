import 'package:comment_section/src/users/models/user.dart';

class Comment {
  final int id;
  final String content;
  final String createdAt;
  final String? replyingTo;
  final User user;
  final List<Comment> replies;
  int score;

  Comment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user,
    this.replyingTo = '',
    this.score = 0,
    this.replies = const []
  });

  Comment.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    content = json['content'],
    createdAt = json['createdAt'],
    replyingTo = json.containsKey('replyingTo') ? json['replyingTo'] : '',
    score = json['score'],
    replies = json.containsKey('replies') ? (json['replies'] as List).map((e) => Comment.fromJson(e)).toList() : [],
    user = User.fromJson(json['user']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'createdAt': createdAt,
    'replyingTo': replyingTo,
    'score': score,
    'replies': replies.map((e) => e.toJson()).toList(),
    'user': user.toJson()
  };
  
}