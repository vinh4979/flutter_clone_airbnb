class RoomModel {
  final String imageUrl;
  final String title;
  final String price;
  final double rating;
  final String? tag; // Thêm dòng này

  RoomModel({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
    this.tag,
  });
}
