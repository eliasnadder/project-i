// bloc/login_event.dart
part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent {
  final String phone;

  const LoginRequested({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class LoginWithPasswordRequested extends LoginEvent {
  final String phone;
  final String password;

  const LoginWithPasswordRequested({required this.phone, required this.password});

  @override
  List<Object?> get props => [phone, password];
}

class RegistrationRequested extends LoginEvent {
  final String name;
  final String phone;
  final String password;
  final String confirmPassword;
  final String location;
  final File? photo;

  const RegistrationRequested({
    required this.name,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.location,
    this.photo,
  });

  @override
  List<Object?> get props => [
        name,
        phone,
        password,
        confirmPassword,
        location,
        photo,
      ];
}

class GetUserRequested extends LoginEvent {
  final String token;

  const GetUserRequested({required this.token});

  @override
  List<Object?> get props => [token];
}

class LogoutUserRequested extends LoginEvent {
  final String token;

  const LogoutUserRequested ({required this.token});

  @override
  List<Object?> get props => [token];
}
