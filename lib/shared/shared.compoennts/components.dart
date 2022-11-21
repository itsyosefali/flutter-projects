import  'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:p/modules/webView/WebViewScreen.dart';

import '../cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backround = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
})=>
    Container(
       width: width,
       child: MaterialButton(
        onPressed: function,
         height: 40.0,
         child: Text(
           isUpperCase ? text.toUpperCase(): text,
             style: TextStyle(
             color: Colors.white
            ),
             ),
            ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backround,

      ),
            );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) => TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        CircleAvatar(
          radius: 35.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:

            [

              Text(

                '${model['title']}',

                style: TextStyle(

                  fontSize: 18.0,

                  fontWeight: FontWeight.bold,

                ),

              ),

              Text(

                '${model['date']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),
            ],

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(

            onPressed:()

            {

              AppCubit.get(context).updateData(

                  status: 'done',

                  id: model['id'],);

            },

            icon: Icon(

              Icons.check_box,

              color: Colors.green,

            )),

        IconButton(

            onPressed:()

            {

              AppCubit.get(context).updateData(

                status: 'archive',

                id: model['id'],);

            },

            icon: Icon(

                Icons.archive_outlined,

              color: Colors.black45,

            )),

      ],

    ),

  ),
  onDismissed: (direction)
  {
      AppCubit.get(context).deleteData(id: model['id'],);
  },
);

Widget tasksBuilder({
  @required List<Map> tasks,
}) =>ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index)
    {
      return buildTaskItem(tasks[index], context);
    },
    separatorBuilder: (context, index) => myDivider(),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);


Widget builedArticleItem(article,context)=>InkWell(
  onTap: (){
    navigaTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children:[
  
        Container(
  
          width: 120.0,
  
          height: 120.0,
  
          decoration: BoxDecoration(
  
              borderRadius: BorderRadius.circular(10.0,),
  
              image: DecorationImage(
  
                image: NetworkImage('${article['urlToImage']}'),
  
                fit: BoxFit.cover,
  
              )
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120.0,
  
            child: Column(
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text(
  
                    '${article['title']}',
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                    maxLines: 4,
  
                    overflow: TextOverflow.ellipsis,
  
                  ),
  
                ),
  
                Text(
  
                  '${article['publishedAt']}',
  
                  style: TextStyle(
  
                    color: Colors.grey,
  
                    fontSize:18.0,
  
                    fontWeight: FontWeight.w600,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

Widget atricleBuilder(list,context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=>builedArticleItem(list[index],context),
      separatorBuilder: (context, index)=> myDivider(),
      itemCount:10),
  fallback: (context)=> isSearch? Container() :Center(child: CircularProgressIndicator()),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

void navigaTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => widget,
),
);

