import 'package:flutter/material.dart';

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
      // التعديل هنا: لو descriptionAr مش موجود في الـ JSON خليه ياخد nameAr
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
      // تعديل: جرب يقرأ name أو nameAr
      nameAr: product.nameAr ?? product.name ?? '',
      nameEn: product.nameEn ?? '',
      price: double.tryParse(product.price.toString()) ?? 0.0,
      imageUrl:
          product.imageUrl ?? product.image ?? '', // تعديل: image أو imageUrl

      // التعديل الأهم للوصف
      descriptionAr: _tryGetDescription(product),
      descriptionEn: '',
      stockQuantity: 1,
      reviews: [],
    );
  }

  static String _tryGetDescription(dynamic p) {
    try {
      // جرب كل الاحتمالات اللي ممكن الـ API يبعتها
      return p.descriptionAr ??
          p.description ??
          p.content ??
          'وصف المنتج متاح في صفحة التفاصيل';
    } catch (e) {
      return 'الوصف غير متوفر حالياً';
    }
  }
}
