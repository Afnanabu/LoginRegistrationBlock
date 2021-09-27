import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_registration_screen/Ui/home_Screen.dart';
import 'package:login_registration_screen/Ui/Login_Screen.dart';


import '../user_model.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();}
class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth=FirebaseAuth.instance;
  final _formkey=GlobalKey<FormState>();
  final firstNameEditingController=new TextEditingController();
  final secondNameEditingController=new TextEditingController();
  final emailEditingController=new TextEditingController();
  final passwordEditingController=new TextEditingController();
  final confirmPasswordEditingController=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final firstNameField=TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,

        validator: (value){
          RegExp regex=new RegExp(r'^.{3,}$');
          if(value!.isEmpty){
            return ('  First Namee  Cannot be Empty');
          }
          if(!regex.hasMatch(value)){
            return ('Enter Valid Name (Min. 3 Character)');

          }
          return null;
        },
        onSaved: (value){
          firstNameEditingController.text=value!;
        },
        textInputAction: TextInputAction.next,
        decoration:InputDecoration(
            prefixIcon: Icon(Icons.person),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'First Name',
            border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
            )
        )

    );

    final secondNameField=TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value){
          if(value!.isEmpty){
            return ('  Second Namee  Cannot be Empty');
          }
          return null;
        },
        onSaved: (value){
          secondNameEditingController.text=value!;
        },
        textInputAction: TextInputAction.next,
        decoration:InputDecoration(
            prefixIcon: Icon(Icons.person),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'Second Name',
            border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
            )
        )

    );

    final emailField=TextFormField(
        autofocus: false,
        controller: emailEditingController,
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
        onSaved: (value){
          emailEditingController.text=value!;
        },
        textInputAction: TextInputAction.next,
        decoration:InputDecoration(
            prefixIcon: Icon(Icons.mail_rounded),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'Email',
            border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
            )
        )

    );
    final passwordField=TextFormField(
        autofocus: false,
        controller: passwordEditingController,
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
        onSaved: (value){
          passwordEditingController.text=value!;},
        textInputAction: TextInputAction.done,
        decoration:InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'Password',
            border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
            )
        )

    );
    final confirmpasswordField=TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value){
          if(confirmPasswordEditingController.text!=passwordEditingController.text){
            return "Password dont match";

          }
          return null;
        },
        onSaved: (value){
          confirmPasswordEditingController.text=value!;},
        textInputAction: TextInputAction.done,
        decoration:InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'Password',
            border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
            )
        )

    );
    final signUpButton=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey.withOpacity(0.1),
      child: MaterialButton(onPressed: (){
        signUp(emailEditingController.text, passwordEditingController.text);},
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: Text("SignUp",textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.blue,),
            onPressed:(){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignInScreen()));}),),
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child:Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 90,child: Image.asset('Image/logo.png',fit: BoxFit.contain,),),
                    SizedBox(height: 25,),
                    firstNameField,
                    SizedBox(height: 20,),
                    secondNameField,
                    SizedBox(height: 20,),
                    emailField,
                    SizedBox(height: 20,),
                    passwordField,
                    SizedBox(height: 20,),
                    confirmpasswordField,
                    SizedBox(height: 20,),
                    signUpButton,
                    SizedBox(height: 20,),
                     ],) ,),) ,),),),);}
  void signUp(String email,String password)async{
    if(_formkey.currentState!.validate())
    {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        postDetailsToFirestore()
      }).catchError((e){
        Fluttertoast.showToast(msg:e!.message);});}}
  postDetailsToFirestore() async{
    //calling our firestore
    //calling user model
    //sending the value
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    User?user=_auth.currentUser;
    UserModel userModel=UserModel();
    // writing all the values
    userModel.email=user!.email;
    userModel.uid=user.uid;
    userModel.firstName=firstNameEditingController.text;
    userModel.secondName=secondNameEditingController.text;
    await firebaseFirestore.collection('users').doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account Create Successfuly :)');
    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);}}