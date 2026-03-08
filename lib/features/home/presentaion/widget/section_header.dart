import 'package:flutter/material.dart';
import 'package:insins/features/home/presentaion/widget/custom_btn_header.dart';

class ShopHeaderWidget extends StatelessWidget {
  const ShopHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: const Color(0xFF5C4A3A),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'المتجر',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              decorationThickness: 2,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'اكتشف عبق الفخامة والأصالة في مكان واحد',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              color: Color(0xFFAAAAAA),
            ),
          ),
          SizedBox(height: 16),
          BreadcrumbWidget(),
        ],
      ),
    );
  }
}
