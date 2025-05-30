class ProductModel {
  final String title;
  final double price;
  final double rating;
  final String thumbnail;
  final String category;
  final List<String>? images;
  final String description;

  ProductModel({
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.category,
    required this.images,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      category: json['category'],
      images: List<String>.from(json['images'] ?? []),
      description: json['description'],
    );
  }
}
