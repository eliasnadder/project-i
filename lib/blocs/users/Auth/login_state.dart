// bloc/login_state.dart
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String status;
  final String phone;

  const LoginSuccess({required this.status, required this.phone});

  @override
  List<Object?> get props => [status, phone];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoginWithPasswordLoading extends LoginState {}

class LoginWithPasswordSuccess extends LoginState {
  final String message;
  final String phone;
  final String token;
  final UserModel userModel;
  const LoginWithPasswordSuccess({
    required this.message,
    required this.phone,
    required this.token,
    required this.userModel,
  });

  @override
  List<Object?> get props => [message, phone, token];
}

class LoginWithPasswordFailure extends LoginState {
  final String message;

  const LoginWithPasswordFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class RegistrationLoading extends LoginState {}

class RegistrationSuccess extends LoginState {
  final String phone;
  final String token;
  final UserModel userModel;
  const RegistrationSuccess({
    required this.phone,
    required this.token,
    required this.userModel,
  });

  @override
  List<Object?> get props => [phone, token];
}

class RegistrationFailure extends LoginState {
  final String message;

  const RegistrationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetUserLoading extends LoginState {}

class GetUserSuccess extends LoginState {
  // final Map<String, dynamic> data;
  final UserModel userModel;
  const GetUserSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class GetUserFailure extends LoginState {
  final String message;

  const GetUserFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class LogoutUserLoading extends LoginState {}

class LogoutUserSuccess extends LoginState {}

class LogoutUserFailure extends LoginState {
  final String message;

  const LogoutUserFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
