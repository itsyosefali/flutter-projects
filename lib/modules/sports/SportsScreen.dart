import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/NewsApp/Cubit/Cubit.dart';
import '../../layout/NewsApp/Cubit/States.dart';
import '../../shared/shared.compoennts/components.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){

        var list =  NewsCubit.get(context).sports;
        return  atricleBuilder(list,context);
      },
    );
  }
}
