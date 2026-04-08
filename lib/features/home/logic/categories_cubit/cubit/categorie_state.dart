part of 'categories_cubit.dart';

@immutable
sealed class CategorieState {}

final class CategoriecubitInitial extends CategorieState {}

class CategoriesLoading extends CategorieState {}

class CategoriesLoaded extends CategorieState {
  final List<CategoryModel> categories;

  CategoriesLoaded(this.categories);

  // ✅ عشان الـ Bloc يشوفها state جديدة دايماً
  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode =>
      categories.hashCode ^ DateTime.now().millisecondsSinceEpoch;
}

class CategorriesError extends CategorieState {
  final String message;
  CategorriesError(this.message);
}
