import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterState extends Equatable{
  const RegisterState();

  @override
  List<Object?> get props => [];
}
class RegisterInitial extends RegisterState{}
class RegisterLoading extends RegisterState{}
class RegisterSucced extends RegisterState{
  User user;
  RegisterSucced({required this.user});
}
class RegisterFaild extends RegisterState{
  String message;
  RegisterFaild({required this.message});
}