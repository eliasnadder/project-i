import 'profile_photo_page.dart';
import 'package:flutter/material.dart';
import 'otp_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/users/Auth/login_bloc.dart';
import '../../components/fields/custom_confirm_password_field.dart';
import '../../components/fields/custom_field.dart';
import '../../components/fields/custom_password_field.dart';
import '../../components/indicators/custom_indicator.dart';
import '../../constants/themes/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static String id = 'signUpPage';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is RegistrationSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => OTPPage()),
              (route) => false,
            );
          } else if (state is RegistrationFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.sign_up,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),
                  CustomField(
                    name: localizations.name,
                    filled: true,
                    errorMessage: localizations.name_error,
                    controller: nameController,
                  ),
                  const SizedBox(height: 16),

                  CustomPasswordField(
                    name: localizations.password,
                    passwordController: passwordController,
                    emptyErrorMessage: localizations.password_error,
                    lengtherrorMessage: localizations.password_length_error,
                  ),
                  const SizedBox(height: 16),

                  CustomConfirmPasswordField(
                    name: localizations.confirm_password,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    confirmErrorMessage: localizations.confirm_password_error,
                    dosnotMatchErrorMessage: localizations.doesnt_match,
                  ),

                  const SizedBox(height: 24),
                  state is RegistrationLoading
                      ? Center(
                        child: CustomIndicator(
                          color: AppColors.primary,
                          size: 56,
                        ),
                      )
                      : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              context.read<LoginBloc>().add(
                                RegistrationRequested(
                                  name: nameController.text,
                                  phone: '',
                                  location: locationController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                ),
                              );
                            }
                            Navigator.pushNamed(context, ProfilePhotoPage.id);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            localizations.register,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
