import 'package:bloc/bloc.dart';
import 'package:login_registration_screen/register/register_event.dart';
import 'package:login_registration_screen/register/register_state.dart';
import 'package:login_registration_screen/reposeitories/user_repositories.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  UserRepository? userRepository;
  RegisterBloc({this.userRepository} ) : super(RegisterInitial());


  Stream<RegisterState>mapEventToState(
      RegisterEvent event,

      )async*{
    if(event is SignUpButtonPress){
      yield RegisterLoading();
      try{
     var user=await userRepository!.signUp(event.email!,event.password!);
     yield RegisterSucced(user: user!);

      }
      catch(e){
        yield RegisterFaild(message: e.toString());
      }
    }
  }

}