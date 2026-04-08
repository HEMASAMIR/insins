class ReviewRequestModel {
  final int productId;
  final String customerName;
  final int rating;
  final String comment;

  ReviewRequestModel({
    required this.productId,
    required this.customerName,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      "ProductId": productId, // ✅ Capital P
      "CustomerName": customerName, // ✅ Capital C و N
      "Rating": rating, // ✅ Capital R
      "Comment": comment, // ✅ Capital C
    };
  }

  factory ReviewRequestModel.fromJson(Map<String, dynamic> json) {
    return ReviewRequestModel(
      // هنا بنقرأ اللي جاي من السيرفر، فتأكد من الأسماء بردو
      productId: json['product_id'] ?? 0,
      customerName: json['customer_name'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
    );
  }
}
