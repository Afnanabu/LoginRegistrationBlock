import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

  class AuthState extends Equatable{
  const AuthState();
  List<Object> get props=>[];

}
class AuthInitial extends AuthState{}
class AuthenticateState extends AuthState{
  User user;
  AuthenticateState({required this.user});
}
class UnAuthenticateState extends AuthState{}