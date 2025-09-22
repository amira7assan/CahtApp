import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
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

  Future<void> RegisterUser({required String email , required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email,password: password,);
      emit(RegisterSuccess());
    }
    on FirebaseAuthException catch (ex){
      if(ex.code == 'weak-password'){
        emit(RegisterFailure(errorMSG: 'weak-password'));
      }
      else if(ex.code == 'email-already-in-use'){
        emit(RegisterFailure(errorMSG: 'email-already-in-use'));
      }
    }
    on Exception catch (e) {
      emit(RegisterFailure(errorMSG: 'ERROR'));
    }
  }
}
