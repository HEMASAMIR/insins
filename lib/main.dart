import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/home/presentaion/view/home.dart';

void main() {
  runApp(const InsinsApp());
}

class InsinsApp extends StatelessWidget {
  const InsinsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Insins App',
          theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Cairo'),
          home: const LuxuryHomePage(),
        );
      },
    );
  }
}
