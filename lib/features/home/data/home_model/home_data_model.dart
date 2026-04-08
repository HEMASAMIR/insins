class ProductModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final double price;
  final String? imageUrl; // ✅ nullable
  final int stockQuantity;
  final String? categoryName; // ✅ nullable

  const ProductModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.price,
    this.imageUrl,
    required this.stockQuantity,
    this.categoryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'], // ✅ nullable — مش بنحط ?? ''
      stockQuantity: json['stockQuantity'] ?? 0,
      categoryName: json['categoryName'], // ✅ nullable
    );
  }
}
