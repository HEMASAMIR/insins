class ProductModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final double price;
  final String imageUrl;
  final int stockQuantity;
  final String categoryName;

  const ProductModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.price,
    required this.imageUrl,
    required this.stockQuantity,
    required this.categoryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        nameAr: json['nameAr'] ?? '',
        nameEn: json['nameEn'] ?? '',
        price: (json['price'] as num).toDouble(),
        imageUrl: json['imageUrl'] ?? '',
        stockQuantity: json['stockQuantity'] ?? 0,
        categoryName: json['categoryName'] ?? '',
      );
}
