import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/newscubit.dart';

import '../cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News APP'),
            actions: [
              IconButton(
                onPressed: () {
                  NewsCubit.get(context).changeAppMode();
                },
                icon: cubit.isDark
                    ? const Icon(Icons.wb_sunny_outlined)
                    : const Icon(Icons.brightness_2_outlined),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavbar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
