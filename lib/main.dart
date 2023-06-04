import 'package:faheem/Login.dart';
import 'package:faheem/RecommendQuiz.dart';
import 'package:faheem/cubit/cubit.dart';
import 'package:faheem/recommend_quiz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'componanet/constant_maneger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => HomeCubit(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("ar", "AE"),
      // OR Locale('ar', 'AE') OR Other RTL locales,
      //home: const HomeExpert()
      // home: BottomTabBarr(),
      home: RecommendQuiz1(),
      // home: editProfile(),
      // home: ProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
