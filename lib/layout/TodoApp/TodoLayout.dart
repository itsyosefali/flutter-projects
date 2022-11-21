import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:p/modules/ArchivedTasks/ArchivedTasksScreen.dart';
import 'package:p/modules/DoneTasks/DoneTasksScreen.dart';
import 'package:p/modules/NewTasksk/NewTasks.dart';
import 'package:p/shared/cubit/cubit.dart';
import 'package:p/shared/cubit/states.dart';
import 'package:p/shared/shared.compoennts/components.dart';
import 'package:p/shared/shared.compoennts/constans.dart';
import 'package:sqflite/sqflite.dart';
import 'package:conditional_builder/conditional_builder.dart';

//1. create DB
//2. crete table
//3. open DB
//4. insert to DB
//5. get from DB
//6. update DB
//7. delete DB


class HomeLayout extends StatelessWidget
  {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context)
  {
  return BlocProvider(
    create: (BuildContext context)=> AppCubit()..createdatabase(),
    child: BlocConsumer<AppCubit, AppState>(
      listener: (BuildContext context, AppState state){
        if(state is AppInsertDataBase)
          {
            Navigator.pop(context);
          }
      },
      builder: (BuildContext context, AppState state){
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              cubit.Title[cubit.currentindex],
            ),
          ),
          body:ConditionalBuilder(
            condition: state is ! AppGetDataBaseLoadingState ,
            builder: (context)=>cubit.screens[cubit.currentindex],
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {
              if(cubit.isBottomSheetShown)
              {
                if(formKey.currentState.validate())
                  {
                    cubit.isnertdatabase(
                        title: titleController.text,
                        time:  timeController.text,
                      date: dateController.text,
                    );
              //    isnertdatabase(
              //      title: titleController.text,
              //      time: timeController.text,
              //      date: dateController.text,
             //     ).then((value)
             //     {
              //      getDataFromDataBase(database).then((value)
               //     {
                //      Navigator.pop(context);

                      //setState(() {
                      // isBottomSheetShown=false;
                      // fabIcon = Icons.edit;
                      //  tasks=value;
                          //  print(tasks);
                      //});
                  //  });

               //   });
                }
              }else
              {
                scaffoldKey.currentState.showBottomSheet(
                      (context) => Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0,),
                    child: Form(
                      key:formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min ,
                        children:
                        [
                          defaultFormField
                            (
                            controller: titleController ,
                            type: TextInputType.text,
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'title must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Title' ,
                            prefix: Icons.title,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField
                            (
                            controller: timeController  ,
                            type: TextInputType.datetime,
                            onTap: ()
                            {
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now()
                              ).then((value)
                              {
                                timeController.text = value.format(context).toString();
                                print(value.format(context));
                              });
                            },
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'time must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Time' ,
                            prefix: Icons.watch_later_outlined,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField
                            (
                            controller: dateController  ,
                            type: TextInputType.datetime,
                            onTap: ()
                            {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2024-05-03'),
                              ).then((value)
                              {
                                print(DateFormat.yMMMd().format(value));
                                dateController.text = DateFormat.yMMMd().format(value);
                              });
                            },
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'date must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Date' ,
                            prefix: Icons.calendar_today,
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 20.0,
                ).closed.then((value)
                {
                  cubit.changeBottomSheetState(
                    isShow: false,
                    icon: Icons.edit,
                  );
                });
                cubit.changeBottomSheetState(
                  isShow: true,
                  icon: Icons.add,);
              }
            },
            child: Icon(
              cubit.fabIcon,
            ),

          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentindex ,
            onTap: (index)
            {
              cubit.changeIndex(index);
            },
            items:
            [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                ),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle_outline,
                ),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive_outlined,
                ),
                label: 'Archived',
              ),
            ],
          ),
        );
      },
    ),
  );
  }

  //  Instance of 'Future<String>'
  //Future<String> getName() async
  //{
  // return'Ahmed Ali';
  //}


}

