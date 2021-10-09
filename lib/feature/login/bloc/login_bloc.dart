import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/common/data/model/result.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithEmailPassEvent) {
      yield LoginLoadingState();
      final result = await _loginWithEmailPass(event.email, event.pass);
      if (result is Success) {
        yield LoginSuccessState();
      } else {
        yield LoginFailedState(result);
      }
    }
  }

  Future<Result> _loginWithEmailPass(String email, String password) async {
    try {
      final cd = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cd.user!;
      return Success();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return Error();
    }
  }

}
