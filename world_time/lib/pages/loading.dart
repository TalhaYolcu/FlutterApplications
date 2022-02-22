

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:world_time/services/world_time.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  
  //String time='loading';

  void setUpWorldTime() async {
    WorldTime instance=WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await instance.getTime();

    /*print(instance.time);
    setState(() {
      time=instance.time;
    });

     */

    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location':instance.location,
      'flag':instance.flag,
      'time':instance.time,
      'isDaytime':instance.isDaytime
    });
  }


  @override
  void initState() {
    super.initState();
    //print('initState function ran');
    //getTime();
    //print('hey there');
    setUpWorldTime();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      /*body: Padding(
        padding: EdgeInsets.all(50),
        //child: Text(time),
        //child: Text('loading'),

      ),
       */
      body: Center(
        child: SpinKitFadingCube(
          color:Colors.white,
          size: 80,
        ),
      ),
    );
  }
}
