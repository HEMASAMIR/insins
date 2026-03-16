class SubCategoryModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String? imageUrl;
  final List<dynamic> products; // يفضل استبدال dynamic بـ ProductModel لو موجود

  SubCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.imageUrl,
    this.products = const [],
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      imageUrl: json['imageUrl'],
      // تعديل هنا: لو مش موجودة أو نال، خليها لستة فاضية []
      products: (json['products'] as List<dynamic>?) ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nameAr': nameAr,
        'nameEn': nameEn,
        'imageUrl': imageUrl,
        'products': products,
      };
}

class CategoryModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String? imageUrl;
  final List<SubCategoryModel> subCategories;

  CategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.imageUrl,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      imageUrl: json['imageUrl'],
      subCategories: (json['subCategories'] as List<dynamic>? ?? [])
          .map((e) => SubCategoryModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nameAr': nameAr,
        'nameEn': nameEn,
        'imageUrl': imageUrl,
        'subCategories': subCategories.map((e) => e.toJson()).toList(),
      };
}
