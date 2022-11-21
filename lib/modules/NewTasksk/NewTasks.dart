import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/shared/cubit/cubit.dart';
import 'package:p/shared/cubit/states.dart';
import 'package:p/shared/shared.compoennts/components.dart';
import 'package:p/shared/shared.compoennts/constans.dart';

class NewTasksScreen extends StatelessWidget
{
    @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state){},
      builder: (context, state){
      var tasks = AppCubit.get(context).newtasks;
      return tasksBuilder(
        tasks: tasks,
      );
    },
    );
  }
}
