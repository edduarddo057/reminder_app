import 'package:flutter/material.dart';
import 'package:reminder_app/home.dart';
import 'package:reminder_app/theme/color_schemes.g.dart';

void main()  {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lembretes',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:  const Color(0xFFA6F5A6),
          title: const Text('Lembretes',style: TextStyle(color: Color(0xFF002106)),),
        ),
        body: Home(),
      ),
    );
  }
}