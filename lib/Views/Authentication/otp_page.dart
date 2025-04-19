import 'package:flutter/material.dart';
import 'package:example1/Views/home_page.dart';
import 'package:example1/constants/themes/custom_theme.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constants/fonts/custom_fonts.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});
  static String id = 'OTPPage';

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _formKey = GlobalKey<FormState>();
  String? _otpCode;

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    // Title
                    const Text(
                      'OTP Verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Image with responsive size
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: SvgPicture.asset(
                        'assets/illustrations/message-sent.svg',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          localizations.otp_sent,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: CustomFonts.enFonts,
                          ),
                        ),
                        Text(
                          'name@examle.com',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: CustomFonts.enFonts,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // OTP Text Field
                    OtpTextField(
                      autoFocus: true,
                      decoration: const InputDecoration(filled: true),
                      borderColor: AppColors.primary,
                      focusedBorderColor: AppColors.primary,
                      cursorColor: AppColors.primary,
                      showFieldAsBox: false,
                      borderWidth: 3.5,
                      onCodeChanged: (String code) {
                        setState(() {
                          _otpCode = code;
                        });
                      },
                      onSubmit: (String verificationCode) {
                        setState(() {
                          _otpCode = verificationCode;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                    // Responsive Button
                    SizedBox(
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        onPressed:
                            (_otpCode != null && _otpCode!.isNotEmpty)
                                ? () {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return MyHomePage();
                                        },
                                      ),
                                    );
                                  }
                                }
                                : null,
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
                          localizations.check_otp,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
