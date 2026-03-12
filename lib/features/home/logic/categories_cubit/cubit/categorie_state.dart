part of 'categories_cubit.dart';

@immutable
sealed class CategorieState {}

final class CategoriecubitInitial extends CategorieState {}

// ══════════════════════════════════════════════════════════
// Categories States
// ══════════════════════════════════════════════════════════
class CategoriesLoading extends CategorieState {}

class CategoriesLoaded extends CategorieState {
  final List<CategoryModel> categories;
  CategoriesLoaded(this.categories);
}

class CategorriesError extends CategorieState {
  final String message;
  CategorriesError(this.message);
}
