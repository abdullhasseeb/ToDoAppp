import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoappp/constants/color.dart';
import 'package:todoappp/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

     MaterialColor myCustomColor = MaterialColor(
       0xffFFBB5C,
      <int, Color>{
        50: Color(0xFFFFE7B2),
        100: Color(0xFFFFD480),
        200: Color(0xFFFFC04F),
        300: Color(0xFFFFAC1E),
        400: Color(0xFFFF9A00),
        500: Color(0xffFFBB5C),
        600: Color(0xFFFF8100),
        700: Color(0xFFFF7000),
        800: Color(0xFFFF5E00),
        900: Color(0xFFFF4B00),
      },
    );
     
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'MondayRain',
        primarySwatch: myCustomColor,
        primaryColor: tdYellow
      ),
      home: Home()
    );
  }
}
