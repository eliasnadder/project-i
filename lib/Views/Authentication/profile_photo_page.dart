import 'dart:io';

import 'package:flutter/material.dart';
import 'package:example1/Views/Authentication/otp_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/users/Auth/login_bloc.dart';
import '../../components/indicators/custom_indicator.dart';
import '../../constants/themes/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePhotoPage extends StatefulWidget {
  const ProfilePhotoPage({super.key});
  static String id = 'ProfilePhotoPage';
  @override
  _ProfilePhotoPageState createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedPhotoPath;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final screenSize = MediaQuery.of(context).size;

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
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.add_profile_photo,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                selectedPhotoPath != null
                                    ? selectedPhotoPath!.startsWith('http')
                                        ? NetworkImage(selectedPhotoPath!)
                                        : FileImage(File(selectedPhotoPath!))
                                            as ImageProvider
                                    : null,
                            child:
                                selectedPhotoPath == null
                                    ? const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: AppColors.primary,
                                    )
                                    : null,
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              onPressed: () async {
                                await _pickImage();
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 56),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.45,

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, OTPPage.id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            localizations.skip,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      state is RegistrationLoading
                          ? Center(
                            child: CustomIndicator(
                              color: AppColors.primary,
                              size: 56,
                            ),
                          )
                          : SizedBox(
                            width: screenSize.width * 0.45,
                            child: ElevatedButton(
                              onPressed: () {
                                // if (_formKey.currentState?.validate() == true) {
                                //   context.read<LoginBloc>().add(
                                //     RegistrationRequested(
                                //       firstName: firstNameController.text,
                                //       lastName: lastNameController.text,
                                //       phone: '',
                                //       location: locationController.text,
                                //       password: passwordController.text,
                                //       confirmPassword:
                                //           confirmPasswordController.text,
                                //       photo:
                                //           selectedPhotoPath != null
                                //               ? File(selectedPhotoPath!)
                                //               : null,
                                //     ),
                                //   );
                                // }
                                Navigator.pushNamed(context, OTPPage.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 50),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 2,
                              ),
                              child: Text(
                                localizations.continuee,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                    ],
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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedPhotoPath = image.path;
      });
    }
  }
}
