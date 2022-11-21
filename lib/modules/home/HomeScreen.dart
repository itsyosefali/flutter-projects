import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          'Home',
        ),
        actions:
        [
          IconButton(
            icon:  Icon(
              Icons.notification_important,
            ),
            onPressed: ()
            {
                print('Hi Bro!');
            },
          ),
          IconButton(
            icon:  Icon(
              Icons.music_note,
            ),
            onPressed: (){
              print("Hi");
            },
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.black87,
          child: Column(

            children: [
               Padding(
                 padding: const EdgeInsets.all(50.0),
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(
                         20.0,
                     ),
                   ),
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   child: Stack(
                      alignment: Alignment.bottomCenter,
                     children: [

                       Image(
                           image: NetworkImage(
                             'https://assets.entrepreneur.com/content/3x2/2000/20171122142613-shutterstock-705666487.jpeg?crop=1:1',
                           ),
                         height: 200.0,
                         width: 200.0,
                         fit: BoxFit.cover,
                       ),
                       Container(
                         padding: EdgeInsets.symmetric(
                           vertical: 10.0,
                         ),
                         width: 200.0,
                         color: Colors.black.withOpacity(.7),
                         child: Text(
                           'Games',
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             fontSize: 20.0,
                              color: Colors.white,
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
               ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [

                      Image(
                        image: NetworkImage(
                            'https://cdn.salla.sa/rZRbl/design/mbjTj5Aa7lJzWqi3ySXExQnoH7helstnAfpN1YWF.jpg?rand=0.2578896192740654?rand=0.18309087488544273',
                        ),
                        height: 200.0,
                        width: 200.0,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        width: 200.0,
                        color: Colors.black.withOpacity(.7),
                        child: Text(
                          'Pcs',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [

                      Image(
                        image: NetworkImage(
                          'https://www.emaratalyoum.com/polopoly_fs/1.1628310.1651952843!/image/image.JPG',
                        ),
                        height: 200.0,
                        width: 200.0,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        width: 200.0,
                        color: Colors.black.withOpacity(.7),
                        child: Text(
                          'Ronaldo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
