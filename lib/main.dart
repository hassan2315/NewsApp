import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/network/remote/diohelper.dart';
import 'package:news_app/screens/news_layout.dart';

import 'cubit/newscubit.dart';
import 'cubit/states.dart';

void main() async {
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
              ..getSports()
              ..getBusiness()
              ..getScience()),
        BlocProvider(
          create: (context) => NewsCubit()..changeAppMode(),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.red,
                    statusBarBrightness: Brightness.light),
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.black),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 20,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                  bodyLarge: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('3A3B3C'),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.red,
                    statusBarBrightness: Brightness.light),
                backgroundColor: HexColor('3A3B3C'),
                elevation: 0,
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20,
                backgroundColor: HexColor('3A3B3C'),
              ),
              textTheme: const TextTheme(
                  bodyLarge: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            themeMode: NewsCubit.get(context).isDark == true
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}
