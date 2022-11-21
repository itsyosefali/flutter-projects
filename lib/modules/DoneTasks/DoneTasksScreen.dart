import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/shared.compoennts/components.dart';

class DoneTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state){},
      builder: (context, state){
        var tasks = AppCubit.get(context).donetasks;
        return tasksBuilder(
          tasks: tasks,
        );
      },
    );

  }
}
