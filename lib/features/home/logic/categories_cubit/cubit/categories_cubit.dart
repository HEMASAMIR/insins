import 'package:bloc/bloc.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/data/home_repo/categories_repo/categories_repo.dart';
import 'package:meta/meta.dart';

part 'categorie_state.dart';

class CategorieCubit extends Cubit<CategorieState> {
  final CategoriesRepo repository;

  // بنحفظ كل الأقسام هنا عشان لما نفلتر منغير ما نكلم السيرفر تاني
  List<CategoryModel> allCategories = [];

  CategorieCubit(this.repository) : super(CategoriecubitInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    final result = await repository.getCategories();

    result.fold(
      (failure) => emit(CategorriesError(failure.message)),
      (categories) {
        allCategories = categories; // بنشيل النسخة الأصلية هنا
        emit(CategoriesLoaded(categories));
      },
    );
  }

  // الوظيفة الجديدة للفلترة
  // void selectCategory(int subCategoryId) {
  //   if (allCategories.isEmpty) return;

  //   if (subCategoryId == 0) {
  //     emit(CategoriesLoaded(allCategories));
  //   } else {
  //     // ✅ فلترة على الـ subCategory
  //     final filtered = allCategories
  //         .map((cat) => CategoryModel(
  //               id: cat.id,
  //               nameAr: cat.nameAr,
  //               nameEn: cat.nameEn,
  //               imageUrl: cat.imageUrl,
  //               subCategories: cat.subCategories
  //                   .where((sub) => sub.id == subCategoryId)
  //                   .toList(),
  //             ))
  //         .where((cat) => cat.subCategories.isNotEmpty)
  //         .toList();

  //     emit(CategoriesLoaded(filtered));
  //   }
  // }

  void selectCategory(int subCategoryId) {
    if (allCategories.isEmpty) return;

    if (subCategoryId == 0) {
      // ✅ رجّع النسخة الأصلية كاملة
      emit(CategoriesLoaded(List.from(allCategories)));
    } else {
      final filtered = allCategories
          .map((cat) => CategoryModel(
                id: cat.id,
                nameAr: cat.nameAr,
                nameEn: cat.nameEn,
                imageUrl: cat.imageUrl,
                subCategories: cat.subCategories
                    .where((sub) => sub.id == subCategoryId)
                    .toList(),
              ))
          .where((cat) => cat.subCategories.isNotEmpty)
          .toList();

      emit(CategoriesLoaded(filtered));
    }
  }
}
