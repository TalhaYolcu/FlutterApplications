import 'package:flutter/material.dart';

int a=0;


void main() {

  runApp(MaterialApp(
    home:Scaffold(
      appBar:AppBar(
        title: Text('my first app'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Hello World'),
      ),
      floatingActionButton: FloatingActionButton(
        child:Text('click'),
        onPressed: ()=> {
          print(a++)
        },
      ),
    ),
  ));
}



