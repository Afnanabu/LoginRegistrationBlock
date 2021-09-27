import 'package:bloc/bloc.dart';
 import 'package:login_registration_screen/auth/auth_event.dart';
import 'package:login_registration_screen/auth/auth_state.dart';
import 'package:login_registration_screen/reposeitories/user_repositories.dart';

 class AuthBloc extends Bloc<AuthEvent,AuthState>{
  UserRepository? userRepository;
  AuthBloc({ this.userRepository}):super(AuthInitial());

  Stream<AuthState> mapEventToState(
      AuthEvent event,
      )
  async*{
    if(event is Apploaded){
      try{
    var isSignedIn= await   userRepository!.isSignedIn();



      if(isSignedIn){
       var user=await userRepository!.getCurrentUser();
       yield AuthenticateState(user: user!);
      }else{
        yield UnAuthenticateState();
      }

    }catch(e){
        yield UnAuthenticateState();
      }
      }
  }
}
