class UserImage {
  final String png;
  final String webp;

  UserImage({
    required this.png,
    this.webp = ''
  });

  UserImage.fromJson(Map<String, dynamic> json)
  : png = json['png'],
    webp = json['webp'];

  Map<String, dynamic> toJson() => {
    'png': png,
    'webp': webp,
  };
}