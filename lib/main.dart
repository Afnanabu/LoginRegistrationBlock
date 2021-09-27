import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_screen/Ui/Splash_Screen.dart';
import 'package:login_registration_screen/Ui/Register_Screen.dart';
import 'package:login_registration_screen/login/login_bloc.dart';
import 'package:login_registration_screen/register/register_bloc.dart';
import 'package:login_registration_screen/reposeitories/user_repositories.dart';
import 'auth/auth_bloc.dart';
    Future <void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    UserRepository userRepository=UserRepository(firebaseAuth: FirebaseAuth.instance);
    return MultiBlocProvider(

      providers: [
        BlocProvider(
          create: (context)=>AuthBloc(userRepository:userRepository ),

        ),
        BlocProvider(
          create: (context)=>RegisterBloc(userRepository:userRepository ),

        ), BlocProvider(
          create: (context)=>LoginBloc(userRepository:userRepository ),

        ),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
           home:SplachScreen(),

       ),
    );
  }
}
