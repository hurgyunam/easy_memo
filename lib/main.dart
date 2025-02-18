import 'dart:ui';

import 'package:easy_memo/scaffold/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
            background: Colors.white,
            outline: Color(0x34545456),
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: Color(0xFFE9E9E9),
          textTheme: TextTheme(
            displaySmall: TextStyle(
              fontFamily: "NotoSansKR",
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
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
