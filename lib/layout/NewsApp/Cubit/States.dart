abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

class NewsLodingState extends NewsState {}

class NewsGetBusinessSuccessState extends NewsState {}

class NewsGetBusinessErrorState extends NewsState
{
  final String error ;

  NewsGetBusinessErrorState(this.error);
}
class NewsGetSportsLoadinState extends NewsState {}

class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsErrorState extends NewsState
{
  final String error ;

  NewsGetSportsErrorState(this.error);
}

class NewsGetscienceLoadinState extends NewsState {}

class NewsGetscienceSuccessState extends NewsState {}

class NewsGetscienceErrorState extends NewsState
{
  final String error ;

  NewsGetscienceErrorState(this.error);
}
class NewsGetsearchLoadinState extends NewsState {}

class NewsGetsearchSuccessState extends NewsState {}

class NewsGetsearchErrorState extends NewsState
{
  final String error ;

  NewsGetsearchErrorState(this.error);
}

