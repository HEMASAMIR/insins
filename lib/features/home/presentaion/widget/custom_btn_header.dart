import 'package:flutter/material.dart';

class BreadcrumbWidget extends StatelessWidget {
  const BreadcrumbWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3728),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.home, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Text(
            'الرئيسية',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('/',
                style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 15)),
          ),
          Text(
            'المتجر',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 15,
              color: Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
    );
  }
}
