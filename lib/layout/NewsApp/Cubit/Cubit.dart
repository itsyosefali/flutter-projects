import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/layout/NewsApp/Cubit/States.dart';
import 'package:p/modules/SettingsScreen/SettingsScreen.dart';
import 'package:p/modules/business/BusinessScreen.dart';
import 'package:p/modules/science/ScienceScreen.dart';
import 'package:p/modules/sports/SportsScreen.dart';

import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),

  ];

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    SciencesScreen(),
  ];

  void chaneBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1)
      getSports();
    if (index == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsLodingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '09bd64c2281b441cab207648d01e83c7',
      },
    ).then((value) {
      //print(value.data.['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadinState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '09bd64c2281b441cab207648d01e83c7',
        },
      ).then((value) {
        //print(value.data.['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetscienceLoadinState());

    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '09bd64c2281b441cab207648d01e83c7',
        },
      ).then((value) {
        //print(value.data.['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetscienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetscienceErrorState(error.toString()));
      });
    }
    else {
      emit(NewsGetscienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {

    emit(NewsGetscienceLoadinState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '09bd64c2281b441cab207648d01e83c7',
      },
    ).then((value) {
      //print(value.data.['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetsearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetsearchErrorState(error.toString()));
    });
  }
  }
