import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();
  // await AppServices.init();
  // await GetStorage.init();
  // AppConfig.init(Flavors.PRODUCTION);
  // SystemChrome.setSystemUIOverlayStyle(setStatusBarColor());
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Infinite Digital Security",
      // theme: lightTheme,
      // darkTheme: darkTheme,
      // themeMode: ThemeMode.light,
      // getPages: AppPages(),
      // initialRoute: SplashPage.routeName,
    );
  }
}
