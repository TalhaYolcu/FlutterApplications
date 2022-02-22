import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; //location name for the UI
  late String time; //time in that location
  late String flag;//url to an asset flag icon
  late String url;//location url for api endpoint
  late bool isDaytime;//true or false if daytime or not




  WorldTime({required this.location,required this.flag,required this.url});

  Future<void> getTime() async {
    /*
    //simulate network request for a username
    String username = await Future.delayed(Duration(seconds: 3),() {
      return 'yoshi';
    });

    //simulate network request to get bio of the username
    String bio = await Future.delayed(Duration(seconds: 2),() {
      return 'vega, musician & egg collector';
    });

    print('$username - $bio');
     */

    /*Response response = await get('https://jsonplaceholder.typicode.com/todos/1');
    Map data = jsonDecode(response.body);
    print(data);
    print(data['title']);
     */


    try {
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data=jsonDecode(response.body);
      //print(data);

      //get properties from data
      String dateTime=data['datetime'];
      String offset=data['utc_offset'].toString().substring(1,3);


      //print(dateTime);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours:int.parse(offset)));
      //print(now);

      //set the time property
      //time=now.toString();

      isDaytime = now.hour>6 && now.hour<20 ? true : false;

      time=DateFormat.jm().format(now);
    }
    catch(e) {
      print('caught error: $e' );
      time='could not get time data';
    }



  }

}


//WorldTime instance=WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
//instance.getTime();