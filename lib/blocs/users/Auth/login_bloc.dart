// bloc/login_bloc.dart
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../models/user_model.dart';
import '../../Constant/constant.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // Listener for LoginRequested
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await http.post(
          Uri.parse('${ConstantVariables.url}/login'),
          body: jsonEncode({'phone': event.phone}),
          headers: {'Content-Type': 'application/json'},
        );

        final responseData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          emit(
            LoginSuccess(status: responseData['status'], phone: event.phone),
          );
        } else {
          emit(
            LoginFailure(message: responseData['message'] ?? 'Login failed'),
          );
        }
      } catch (e) {
        emit(LoginFailure(message: e.toString()));
      }
    });

    on<LoginWithPasswordRequested>((event, emit) async {
      emit(LoginWithPasswordLoading());
      try {
        final response = await http.post(
          Uri.parse('${ConstantVariables.url}/loginWithPassword'),
          body: jsonEncode({
            'phone': event.phone,
            'password': event.password,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        final responseData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          emit(
            LoginWithPasswordSuccess(
              message: responseData['message'],
              phone: event.phone,
              token: responseData['access_token'],
              userModel: UserModel.fromJson(
                  responseData['user'], responseData['image_path']),
            ),
          );
        } else {
          emit(
            LoginWithPasswordFailure(
                message: responseData['message'] ?? 'Login failed'),
          );
        }
      } catch (e) {
        emit(LoginWithPasswordFailure(message: e.toString()));
      }
    });

    // Listener for RegistrationRequested
    on<RegistrationRequested>((event, emit) async {
      emit(RegistrationLoading());
      try {
        // UserModel user = UserModel(
        //   firstName: event.firstName,
        //   lastName: event.lastName,
        //   phone: event.phone,
        //   password: event.password,
        //   location: event.location,
        //   photo: event.photo,
        // );
        final request = http.MultipartRequest(
            'POST', Uri.parse('${ConstantVariables.url}/register'));
        request.fields.addAll({
          'name': event.name,
          'phone': event.phone,
          'password': event.password,
          'password_confirmation': event.confirmPassword,
          'location': event.location,
        });
        if (event.photo != null) {
          request.files.add(await http.MultipartFile.fromPath(
              'image_path', event.photo!.path));
        }

        request.headers.addAll({
          'Accept': 'application/json',
        });
        var response = await request.send();

        if (response.statusCode == 201 || response.statusCode == 200) {
          final data = await response.stream.bytesToString();
          final responseData = jsonDecode(data);
          emit(
            RegistrationSuccess(
              phone: event.phone,
              token: responseData['access_token']['original']['access_token'],
              userModel: UserModel.fromJson(
                  responseData['user'], responseData['image_path']),
            ),
          );
        } else {
          emit(RegistrationFailure(
              message: 'Registration failed ${response.reasonPhrase}'));
        }
      } catch (e) {
        emit(RegistrationFailure(message: e.toString()));
      }
    });

    // Listener for GetUserRequested
    // on<GetUserRequested>((event, emit) async {
    //   emit(GetUserLoading());
    //   try {
    //     final token = await SharedPreferencesHelper.getToken();

    //     if (token == null) {
    //       emit(const GetUserFailure(message: 'User not logged in.'));
    //     }
    //     final response = await http.get(
    //       Uri.parse('${ConstantVariables.url}/user/getUser'),
    //       headers: {
    //         'Content-Type': 'application/json',
    //         'Authorization': 'Bearer ${event.token}',
    //       },
    //     );

    //     final responseData = jsonDecode(response.body);
    //     if (response.statusCode == 200 || response.statusCode == 201) {
    //       UserModel userModel = UserModel.fromJson(
    //           responseData['user'], responseData['image_path']);
    //       emit(GetUserSuccess(userModel: userModel));
    //     } else {
    //       emit(GetUserFailure(
    //           message: responseData['message'] ?? 'Failed to fetch user'));
    //     }
    //   } catch (e) {
    //     emit(GetUserFailure(message: e.toString()));
    //   }
    // });

    on<LogoutUserRequested>((event, emit) async {
      emit(LogoutUserLoading());
      try {
        final response = await http.post(
          Uri.parse('${ConstantVariables.url}/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${event.token}',
          },
        );

        final responseData = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(LogoutUserSuccess());
        } else {
          emit(LogoutUserFailure(
              message: responseData['message'] ?? 'Failed to logout'));
        }
      } catch (e) {
        emit(LogoutUserFailure(message: e.toString()));
      }
    });
  }
}
