import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/NewsApp/Cubit/Cubit.dart';
import '../../layout/NewsApp/Cubit/States.dart';
import '../../shared/shared.compoennts/components.dart';

class SciencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){

        var list =  NewsCubit.get(context).science;
        return  atricleBuilder(list,context);
      },
    );
  }
}
