import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/widgets/category_sub_section.dart';
import 'package:insins/core/widgets/menu_header.dart';
import 'package:insins/core/widgets/menu_section_header.dart';

class CategoryMenuWidget extends StatelessWidget {
  final Function(int categoryId, String categoryName) onCategorySelected; // ✅

  const CategoryMenuWidget({
    super.key,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const MenuHeader(title: 'قسم العطور'),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      MenuSectionHeader(
                        title: "جميع المنتجات",
                        fontSize: 13.sp,
                        onTap: () =>
                            onCategorySelected(0, 'جميع المنتجات'), // 0 = all
                      ),
                      MenuSectionHeader(title: "قسم العطور", fontSize: 13.sp),
                      CategorySubSection(
                        items: const [
                          "عطور رجالية",
                          "عطور نسائية",
                          "عطور الجسم",
                          "عطور الشعر"
                        ],
                        onItemTap: (item) {
                          const map = {
                            'عطور رجالية': 1,
                            'عطور نسائية': 2,
                            'عطور الجسم': 3,
                            'عطور الشعر': 4,
                          };
                          onCategorySelected(map[item]!, item); // ✅
                        },
                      ),
                      const MenuSectionHeader(title: "التجميل من إنسينس"),
                      CategorySubSection(
                        items: const [
                          "المكياج",
                          "العناية بالشعر",
                          "العناية بالبشرة",
                          "العناية بالجسم"
                        ],
                        onItemTap: (item) {
                          const map = {
                            'المكياج': 5,
                            'العناية بالشعر': 6,
                            'العناية بالبشرة': 7,
                            'العناية بالجسم': 8,
                          };
                          onCategorySelected(map[item]!, item); // ✅
                        },
                      ),
                      const MenuSectionHeader(title: "العود من إنسينس"),
                      CategorySubSection(
                        items: const ["العود الطبيعي", "العود المحسن"],
                        onItemTap: (item) {
                          const map = {
                            'العود الطبيعي': 9,
                            'العود المحسن': 10,
                          };
                          onCategorySelected(map[item]!, item); // ✅
                        },
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
