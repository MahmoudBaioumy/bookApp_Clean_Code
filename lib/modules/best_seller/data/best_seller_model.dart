class BookModel {
  final String title;
  final String category;
  final int discountPercent;
  final double oldPrice;
  final double newPrice;
  final String image;

  BookModel({
    required this.title,
    required this.category,
    required this.discountPercent,
    required this.oldPrice,
    required this.newPrice,
    required this.image,
  });
}
