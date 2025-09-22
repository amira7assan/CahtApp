part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class RegisterSuccess extends AuthInitial {}
class RegisterLoading extends AuthInitial {}
class RegisterFailure extends AuthInitial {
  String errorMSG;

  RegisterFailure({required this.errorMSG});
}
class LoginSuccess extends AuthInitial {}
class LoginLoading extends AuthInitial {}
class LoginFailure extends AuthInitial {
  String errorMsg;
  LoginFailure({required this.errorMsg});
}