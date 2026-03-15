import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/di/injection.dart';
import 'package:insins/core/networking/dio_client.dart';
import 'package:insins/core/router/app_bloc_observer.dart';
import 'package:insins/core/router/app_router.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initDio();
  Bloc.observer = AppBlocObserver();
  await setupDI();
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
        return MaterialApp.router(
          scaffoldMessengerKey: snackbarKey,
          debugShowCheckedModeBanner: false,
          title: 'Insins App',
          routerConfig: RouterGenerationConfig.goRouter,
          theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Cairo'),
        );
      },
    );
  }
}
