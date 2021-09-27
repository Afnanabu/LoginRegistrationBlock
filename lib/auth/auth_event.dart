import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();
  List<Object> get props=>[];

}
class Apploaded extends AuthEvent{

}