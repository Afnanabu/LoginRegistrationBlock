import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_screen/Ui/Register_Screen.dart';
 import 'package:login_registration_screen/login/login_bloc.dart';
 import 'package:login_registration_screen/login/login_state.dart';
 import 'home_Screen.dart';
class SignInScreen extends StatelessWidget {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  LoginBloc? loginBloc;

  get firebaseAuth => null;
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    // editing controller
    final TextEditingController emailController = new TextEditingController();
    final TextEditingController passwordController = new TextEditingController();

    @override
 //emailField
      final emailField = TextFormField(
          autofocus: false,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value){
            if(value!.isEmpty){
              return( 'Please Enter Your Email ');
            }
            if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
              return ('Please Enter a valid email ');
            }

            return null;
          },
          onSaved: (value) {
            emailController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.mail_rounded),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )));
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,

        validator: (value){
          RegExp regex=new RegExp(r'^.{6,}$');
          if(value!.isEmpty){
            return ('  Password  is Requerd for login');
          }
          if(!regex.hasMatch(value)){
            return ('Enter Valid Password (Min. 6 Character)');

          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey.withOpacity(0.1),
      child: MaterialButton(
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    loginBloc=BlocProvider.of<LoginBloc>(context);
    return Scaffold(

      appBar: AppBar(backgroundColor:Colors.transparent,
        elevation: 0,

        leading:IconButton(icon: Icon(Icons.arrow_back,color:Colors.blue,),
          onPressed: (){Navigator.pop(context);},),),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(height: 150,
                child: Image.asset('Image/logo.png')),
            BlocListener<LoginBloc,LoginState>
              (listener:(context,state){
              if(state is LoginSucced){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              }
            },
              child: BlocBuilder <LoginBloc,LoginState>(
                builder: (context,state) {
                  if(state is LoginLoading){
                    return Center(
                        child: CircularProgressIndicator());

                  }
                  else if (state is LoginFailed){
                    return buildError(state.message);
                  }
                  else if(state is LoginSucced){
                    emailController.text='';
                    passwordController.text='';
                    return Container();
                  }
                  return Container();
                },
              ),

            ),
            Container(
              height: 500,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 20,),


                  emailField,
                  SizedBox(height: 20,),
                  passwordField,
                  SizedBox(
                    height: 35,
                  ),
                  loginButton,
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have an account ?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegistrationScreen ()));
                        },
                        child: Text(
                          '   SignUp',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget buildError(String message){
    return Text(message,style: TextStyle(color: Colors.red),);
  }
  Future<User?>signIn(String email,String password)async{
    try{
      var auth= await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    }
    catch(e){
      print(e.toString());
    }
  }

}
