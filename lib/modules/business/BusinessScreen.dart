import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/layout/NewsApp/Cubit/Cubit.dart';
import 'package:p/layout/NewsApp/Cubit/States.dart';
import 'package:p/shared/cubit/cubit.dart';
import 'package:p/shared/shared.compoennts/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){

        var list =  NewsCubit.get(context).business;
        return  atricleBuilder(list,context);
      },
    );
  }
}
