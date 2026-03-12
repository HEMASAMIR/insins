import 'package:bloc/bloc.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/data/home_repo/categories_repo/categories_repo.dart';
import 'package:meta/meta.dart';

part 'categorie_state.dart';

class CategorieCubit extends Cubit<CategorieState> {
  final CategoriesRepo repository;
  CategorieCubit(this.repository) : super(CategoriecubitInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());

    final result = await repository.getCategories();

    result.fold(
      (failure) => emit(CategorriesError(failure.message)),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }
}
