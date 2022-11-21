import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/shared/cubit/states.dart';
import 'package:p/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../../modules/ArchivedTasks/ArchivedTasksScreen.dart';
import '../../modules/DoneTasks/DoneTasksScreen.dart';
import '../../modules/NewTasksk/NewTasks.dart';

class AppCubit extends Cubit<AppState>
{
  AppCubit() :  super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<Widget> screens =
  [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> Title =
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index)
  {
    currentindex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database database;
  List<Map> newtasks =[];
  List<Map> donetasks =[];
  List<Map> archivetasks =[];

  void createdatabase()
  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version)
      {
        print('db creted');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value){
          print('Table Created');
        }).catchError((error){
          print('Eror ${error.toString()}');
        });
      },
      onOpen: (database)
      {
      getDataFromDataBase(database);
        print('db opened');
      },
    ).then((value){
      database = value;
      emit(AppCreateDataBase());
    });
  }
   isnertdatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async
  {
    await database.transaction((txn)
    {
      txn.rawInsert
        ('INSERT INTO tasks(title,date,time,status) VALUES ("$title","$date","$time","new")'
      ).then((value)
      {
        print('$value inserted successfully');
        emit(AppInsertDataBase());

        getDataFromDataBase(database);
      }).catchError((error)
      {
        print('Eror Didnt inserted ${error.toString()}');
      });
      return null;
    })  ;
  }

  void getDataFromDataBase(database)
  {
    newtasks = [];
    donetasks = [];
    archivetasks = [];

    emit(AppGetDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      value.forEach((element)
      {
      if(element['status']== 'new')
        newtasks.add(element);
      else if(element['status']== 'done')
        donetasks.add(element);
      else archivetasks.add(element);
      });

      emit(AppGetDataBase());
    });;
  }

  void updateData({
    @required String status,
    @required int id,

  }) async
  {
      database.rawUpdate(
         'UPDATE tasks SET status = ? WHERE id = ?',
     ['$status', id]
     ).then((value)
      {
        getDataFromDataBase(database);
        emit(AppUpdateDataBase());
      });
  }

  void deleteData({
    @required int id,

  }) async
  {
    database.rawDelete(
        'DELETE FROM  tasks WHERE id = ?',
        [id]
    ).then((value)
    {
      getDataFromDataBase(database);
      emit(AppDeleteDataBase());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
  @required bool isShow,
    @required IconData icon,

  })
  {
      isBottomSheetShown = isShow;
      fabIcon = icon;
  emit(AppChangeBottomSheetBarState());
  }
  bool isdark = false;

  void changeAppMode({bool fromShared})
  {
    if(fromShared != null)
    {
      emit(AppChangeState());
      isdark = fromShared;
    }
    else
    {
      isdark = isdark;
      isdark=!isdark;
      CacheHelper.putData(key: 'isDark',value: isdark).then((value){
        emit(AppChangeState());
      });
    }
  }

  
  
}
