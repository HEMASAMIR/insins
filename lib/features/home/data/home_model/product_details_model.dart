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

  // ✅ احسب متوسط التقييم
  double get averageRating {
    if (reviews.isEmpty) return 0.0;
    double total = 0;
    for (var review in reviews) {
      total += (review['rating'] as num).toDouble();
    }
    return double.parse((total / reviews.length).toStringAsFixed(1));
  }

  // ✅ عدد التقييمات
  int get reviewsCount => reviews.length;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      descriptionAr: json['descriptionAr'] ?? json['nameAr'] ?? '',
      descriptionEn: json['descriptionEn'] ?? json['nameEn'] ?? '',
      notes: json['notes'],
      price: (json['price'] as num).toDouble(),
      stockQuantity: json['stockQuantity'] ?? 0,
      imageUrl: json['imageUrl'],
      categoryName: json['categoryName'],
      reviews: json['reviews'] ?? [],
    );
  }

  factory ProductDetailsModel.fromProductModel(dynamic product) {
    return ProductDetailsModel(
      id: product.id ?? 0,
      nameAr: product.nameAr ?? product.name ?? '',
      nameEn: product.nameEn ?? '',
      price: double.tryParse(product.price.toString()) ?? 0.0,
      imageUrl: product.imageUrl ?? product.image ?? '',
      descriptionAr: _tryGetDescription(product),
      descriptionEn: '',
      stockQuantity: 1,
      reviews: [],
    );
  }

  static String _tryGetDescription(dynamic p) {
    try {
      return p.descriptionAr ??
          p.description ??
          p.content ??
          'وصف المنتج متاح في صفحة التفاصيل';
    } catch (e) {
      return 'الوصف غير متوفر حالياً';
    }
  }
}
