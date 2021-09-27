 import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable{
  const RegisterEvent();

  @override
   List<Object?> get props => [];
}
class SignUpButtonPress extends RegisterEvent{
  String? email,password;
  SignUpButtonPress({required this.email,required this.password});
}