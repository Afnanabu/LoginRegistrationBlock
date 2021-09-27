import 'package:bloc/bloc.dart';
import 'package:login_registration_screen/login/login_event.dart';
import 'package:login_registration_screen/login/login_state.dart';
import 'package:login_registration_screen/reposeitories/user_repositories.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  UserRepository? userRepository;
  LoginBloc({this.userRepository}) : super(LoginInitial());

  Stream<LoginState>mapEventToState(
      LoginEvent event,
      )async*{
    if(event is SignInButtonPressed)
    {
      yield LoginLoading();
      try{
        var user=await userRepository!.signIn(event.email,event.password);
        yield LoginSucced(user: user!);

      }
      catch(e){
        yield LoginFailed(message: e.toString());
      }
    }
  }

}