import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/network/remote/diohelper.dart';
import 'package:news_app/screens/Buisness.dart';
import 'package:news_app/screens/science.dart';

import 'package:news_app/screens/sports.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.computer),
      label: 'Technology',
    ),
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  void changeBottomNavbar(int index) {
    currentIndex = index;
    if (index == 0) {
      getBusiness();
    } else if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }

    emit(NewsBottomState());
  }

  bool isDark = false;
  void changeAppMode() {
    isDark = !isDark;
    emit(NewsThemeChanged());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];
  void getBusiness() {
    emit(NewLoadingState());
    if (business.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'business',
          'apiKey': 'aef1bb431e1d418aa3048e88ba28542e'
        },
      )
          .then((value) => {
                business = value?.data['articles'],
                print(business[0]['title']),
                emit(NewsGetBusinessSucessState())
              })
          .catchError((error) {
        emit(NewsGetBusinessErroState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSucessState());
    }
  }

  void getSports() {
    emit(NewLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sports',
          'apiKey': 'aef1bb431e1d418aa3048e88ba28542e'
        },
      )
          .then((value) => {
                sports = value?.data['articles'],
                print(sports[0]['title']),
                emit(NewsGetSportsSucessState())
              })
          .catchError((error) {
        emit(NewsGetSportsErroState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSucessState());
    }
  }

  void getScience() {
    emit(NewLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'technology',
          'apiKey': 'aef1bb431e1d418aa3048e88ba28542e'
        },
      )
          .then((value) => {
                science = value?.data['articles'],
                print(science[0]['title']),
                emit(NewsGetScienceSucessState())
              })
          .catchError((error) {
        emit(NewsGetScienceErroState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSucessState());
    }
  }

  void getSearch(String value) {
    emit(NewLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {'q': value, 'apiKey': 'aef1bb431e1d418aa3048e88ba28542e'},
    )
        .then((value) => {
              search = value?.data['articles'],
              print(search[0]['title']),
              emit(NewsSearchSuccessState())
            })
        .catchError((error) {
      emit(NewsSearchErrorState(error.toString()));
    });
  }
}
