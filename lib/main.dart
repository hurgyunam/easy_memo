import 'package:easy_memo/scaffold/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: Colors.blue,
            secondary: Colors.black,
            tertiary: Colors.grey,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: Color(0xFFE9E9E9),
          textTheme: TextTheme(
            headlineMedium: TextStyle(
              fontFamily: "NotoSansKR",
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            bodyMedium: TextStyle(
              fontFamily: "NotoSansKR",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        home: ScaffoldMain(),
      ),
    );
  }
}
