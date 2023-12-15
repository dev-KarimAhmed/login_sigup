


abstract class AuthState {}

class AuthInitial extends AuthState {}



class RegisterInitial extends AuthState {}
class RegisterSuccess extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterFailure extends AuthState {
  String errMessage;
  RegisterFailure({required this.errMessage});
}
class LoginInitial extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginLoading extends AuthState {}

class LoginFailure extends AuthState {
  String errMessage;
  LoginFailure({required this.errMessage});
}

