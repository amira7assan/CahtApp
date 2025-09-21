import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'login_state.dart';
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> LoginUser({required String email , required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    }on FirebaseAuthException catch (ex){
      if(ex.code == 'user-not-found'){
        emit(LoginFailure(errorMsg: 'user not found'));
      }
      else if(ex.code == 'wrong-password'){
        emit(LoginFailure(errorMsg: 'wrong password'));
      }
    }
    on Exception catch (e) {
      emit(LoginFailure(errorMsg: 'something was wrong'));
    }
  }
}
