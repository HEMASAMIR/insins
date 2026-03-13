import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/widgets/category_sub_section.dart';
import 'package:insins/core/widgets/menu_header.dart';
import 'package:insins/core/widgets/menu_section_header.dart';

class CategoryMenuWidget extends StatelessWidget {
  const CategoryMenuWidget({super.key});

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
              // 1. الهيدر
              const MenuHeader(title: 'قسم العطور'),

              // 2. محتوى القائمة
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      MenuSectionHeader(
                        title: "جميع المنتجات",
                        fontSize: 13.sp,
                        onTap: () {},
                      ),
                      MenuSectionHeader(
                        title: "قسم العطور",
                        fontSize: 13.sp,
                      ),
                      CategorySubSection(
                        items: const [
                          "عطور رجالية",
                          "عطور نسائية",
                          "عطور الجسم",
                          "عطور الشعر"
                        ],
                        onItemTap: (item) => print("Selected: $item"),
                      ),
                      const MenuSectionHeader(title: "التجميل من إنسينس"),
                      CategorySubSection(
                        items: const [
                          "المكياج",
                          "العناية بالشعر",
                          "العناية بالبشرة",
                          "العناية بالجسم"
                        ],
                        onItemTap: (item) => print("Selected: $item"),
                      ),
                      const MenuSectionHeader(title: "العود من إنسينس"),
                      CategorySubSection(
                        items: const ["العود الطبيعي", "العود المحسن"],
                        onItemTap: (item) => print("Selected: $item"),
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
