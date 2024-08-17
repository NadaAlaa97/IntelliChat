import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:task/Presentation/home_page.dart';
import 'package:task/Presentation/login_screen.dart';
import 'package:task/Presentation/register_screen.dart';

void main() async{

  runApp(DevicePreview(
    builder: (context) {
      return const MyApp();
    },
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true
      ),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'IntelliChat',
      initialRoute: RegisterScreen.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context)=> LoginScreen(),
      },
    );
  }
}
