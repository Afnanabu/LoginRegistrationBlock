import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_registration_screen/Ui/Register_Screen.dart';

import 'Login_Screen.dart';


class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      home: MyHomePage(),
      theme: ThemeData.dark(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Timer(Duration(seconds:3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:

                (context) =>SignInScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.black87,
      child: Column(
        children: [
          SizedBox(height: 200,),
          Container(
              child:CircleAvatar(backgroundImage:AssetImage('Image/logo.png'),radius: 100,)

          )
          , SizedBox(height: 60,)
          ,Text('Done By Afnan Abu-saleem',
            style: TextStyle(
              inherit: false,
              color: Colors.blue,
              fontSize: 20,
            ),)
        ],
      ),
    );
  }
}