class ReviewData {
  final String name;
  final String time;
  final String comment;
  final String? imageUrl;

  ReviewData({
    required this.name,
    required this.time,
    required this.comment,
    this.imageUrl,
  });
}