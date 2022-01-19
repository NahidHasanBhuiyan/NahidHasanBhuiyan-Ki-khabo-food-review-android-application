import 'dart:ffi';

import 'package:cse_ccnust/Pages/explorePage.dart';
import 'package:cse_ccnust/Pages/profilePage.dart';
import 'package:cse_ccnust/Pages/restaurantsPage.dart';
import 'package:cse_ccnust/Pages/reviewPage.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  //const Timeline({Key? key}) : super(key: key);
  var location;
  Timeline(this.location);
  @override
  _TimelineState createState() => _TimelineState(this.location);

}

class _TimelineState extends State<Timeline> {
  var location;
  _TimelineState(this.location);
  DateTime _now = DateTime.now();

  String greetings = "";

  int currentIndex = 0;
  final screen = [
    ExplorePage(null),
    ReviewPage(null),
    ProfilePage(),
    RestaurantPage(),
  ];

  //print('timestamp: ${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}');
  @override
  Widget build(BuildContext context) {
    if(_now.hour>2 || _now.hour<11){
      greetings = "Good Morning";
    }else if(_now.hour>11 || _now.hour<14){
      greetings = "Good Noon";
    }
    else if(_now.hour>14 || _now.hour<16){
      greetings = "Good After Noon";
    }else if(_now.hour>16 || _now.hour<19){
      greetings = "Good Evening";
    }else{
      greetings = "Good Night";
    }
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.lightBlue,
      //   title: Column(
      //     children: [
      //       Text('কি খাবো',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
      //       Text(greetings),
      //
      //     ],
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.supervised_user_circle),
      //     onPressed: () {  },
      //   ),
      // ),
      body: Center(
        child: screen[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index)=>setState(() =>
        currentIndex = (index),
        ),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            title: Text('Explore')
          ),

          BottomNavigationBarItem(
              icon: Container(

                  child: Icon(Icons.add,color: Colors.white,),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.indigoAccent,Colors.purple]
                  )
                ),

              ),

              title: Text('Review')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Profile')
          ),
        ],
      ),
    );
  }
}



