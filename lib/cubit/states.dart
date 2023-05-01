abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewLoadingState extends NewsStates {}

class NewsBottomState extends NewsStates {}

class NewsThemeChanged extends NewsStates {}

class NewsGetBusinessSucessState extends NewsStates {}

class NewsGetBusinessErroState extends NewsStates {
  final String error;
  NewsGetBusinessErroState(this.error);
}

class NewsGetSportsSucessState extends NewsStates {}

class NewsGetSportsErroState extends NewsStates {
  final String error;
  NewsGetSportsErroState(this.error);
}

class NewsGetScienceSucessState extends NewsStates {}

class NewsGetScienceErroState extends NewsStates {
  final String error;
  NewsGetScienceErroState(this.error);
}

class NewsSearchSuccessState extends NewsStates {}

class NewsSearchErrorState extends NewsStates {
  final String error;
  NewsSearchErrorState(this.error);
}
