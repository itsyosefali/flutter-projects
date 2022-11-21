import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/layout/NewsApp/Cubit/Cubit.dart';
import 'package:p/layout/NewsApp/Cubit/States.dart';
import 'package:p/modules/search/searchScreen.dart';
import 'package:p/shared/cubit/cubit.dart';
import 'package:p/shared/shared.compoennts/components.dart';
//import 'package:p/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions:
            [
              IconButton(
                  icon:Icon(
                    Icons.search,
                  ),
              onPressed: ()
              {
                navigaTo(context, SearchScreen(), );
              },
              ),
              IconButton(
                  icon:Icon(
                    Icons.brightness_4_outlined,
                  ),
              onPressed: ()
              {
                AppCubit.get(context).changeAppMode();
              },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
          cubit.chaneBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
