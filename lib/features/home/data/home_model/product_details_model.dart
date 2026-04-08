import 'package:insins/features/home/data/cart_model/cart_model.dart';

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

  // ✅ وظيفة تحويل لمنتج السلة (تستخدمها في onAdd)
  CartItemModel toCartItem() {
    return CartItemModel(
      id: id.toString(),
      name: nameAr,
      price: price,
      image: imageUrl ?? '',
      quantity: 1,
    );
  }

  double get averageRating {
    if (reviews.isEmpty) return 0.0;
    double total = 0;
    for (var review in reviews) {
      total += (review['rating'] as num).toDouble();
    }
    return double.parse((total / reviews.length).toStringAsFixed(1));
  }

  int get reviewsCount => reviews.length;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'] ?? 0,
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      descriptionAr: json['descriptionAr'] ?? json['nameAr'] ?? '',
      descriptionEn: json['descriptionEn'] ?? json['nameEn'] ?? '',
      notes: json['notes'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stockQuantity: json['stockQuantity'] ?? 0,
      imageUrl: json['imageUrl'],
      categoryName: json['categoryName'],
      reviews: json['reviews'] ?? [],
    );
  }

  factory ProductDetailsModel.fromProductModel(dynamic product) {
    // كود التحويل كما هو مع تأمين القيم
    return ProductDetailsModel(
      id: product.id ?? 0,
      nameAr: product.nameAr ?? product.name ?? '',
      nameEn: product.nameEn ?? '',
      price: double.tryParse(product.price.toString()) ?? 0.0,
      imageUrl: product.imageUrl,
      descriptionAr:
          product.descriptionAr ?? 'وصف المنتج متاح في صفحة التفاصيل',
      descriptionEn: '',
      stockQuantity: product.stockQuantity ?? 1,
      categoryName: product.categoryName,
      reviews: [],
    );
  }
}
