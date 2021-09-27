import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth? firebaseAuth = FirebaseAuth.instance;
  UserRepository({this.firebaseAuth});
  // sign up with email and paswword
Future<User?>signUp(String email,String password)async{
  try{
  var auth= await firebaseAuth!.createUserWithEmailAndPassword(
      email: email, password: password);
  return auth.user;
  }
  catch(e){
    print(e.toString());
  }
}
// sign in with email an password
Future<User?>signIn(String email,String password)async{
  try{
  var auth= await firebaseAuth!.signInWithEmailAndPassword(
      email: email, password: password);
  return auth.user;
  }
  catch(e){
    print(e.toString());
  }
}
// sinout  with email and password
Future<void>signOut()async{
 await firebaseAuth!.signOut();
}
//check Sign In
  Future<bool>isSignedIn()async{
  var currentUser=  await firebaseAuth!.currentUser;
  return currentUser !=null;
  }
  //get current user
  Future<User?>getCurrentUser()async{
   return await firebaseAuth!.currentUser;
  }
 }