import 'package:comment_section/src/users/models/user_image.dart';

class User {
  final String username;
  final UserImage? image;

  User({
    required this.username,
    this.image
  });

  User.fromJson(Map<String, dynamic> json)
  : username = json['username'],
    image = UserImage.fromJson(json['image']);

  Map<String, dynamic> toJson() => {
    'username': username,
    'image': image?.toJson(),
  };
}