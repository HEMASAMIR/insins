class ProductDetailsModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String? notes;
  final double price;
  final int stockQuantity;
  final String? imageUrl;
  final String? categoryName;
  final List<dynamic> reviews;

  ProductDetailsModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    this.notes,
    required this.price,
    required this.stockQuantity,
    this.imageUrl,
    this.categoryName,
    required this.reviews,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      descriptionAr: json['descriptionAr'] ?? '',
      descriptionEn: json['descriptionEn'] ?? '',
      notes: json['notes'],
      price: (json['price'] as num).toDouble(),
      stockQuantity: json['stockQuantity'] ?? 0,
      imageUrl: json['imageUrl'],
      categoryName: json['categoryName'],
      reviews: json['reviews'] ?? [],
    );
  }
}
