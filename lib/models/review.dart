class Review {
  final String author;
  final String content;
  final String createAt;
  final String url;

  Review(
      {required this.author,
      required this.content,
      required this.createAt,
      required this.url});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'],
      content: json['content'],
      createAt: json['createAt'],
      url: json['url'],
    );
  }
}
