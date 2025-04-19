import 'package:another_flushbar/flushbar.dart';
import 'package:example1/components/indicators/custom_indicator.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/users/Auth/login_bloc.dart';
import '../../constants/themes/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhonePage extends StatefulWidget {
  static String id = 'PhonePage';

  const PhonePage({super.key});

  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage>
    with SingleTickerProviderStateMixin {
  String selectedCountryCode = '+963';
  String phoneHint = 'Enter phone number';
  int maxPhoneLength = 9;

  final _formKey = GlobalKey<FormState>();
  String? _phoneNumber;
  bool _isButtonEnabled = false;
  bool _isInvalidNumber = false;
  bool _isLoading = false;

  late AnimationController _animationController;

  final TextEditingController phoneController = TextEditingController();

  final Map<String, int> countryPhoneLengths = {
    '+963': 9, // Syria
    '+1': 10, // USA
    '+44': 10, // UK
  };
  AppLocalizations lang(BuildContext context) => AppLocalizations.of(context)!;

  Color background = AppColors.primary;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog(BuildContext currentContext) {
    showDialog(
      context: currentContext,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: lang(context).is_correct_number,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  TextSpan(
                    text: requestCode(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                lang(context).edit,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Navigator.of(dialogContext).pop();
                // setState(() => _isLoading = true);
                // await _animationController.forward();
                // currentContext.read<LoginBloc>().add(
                //       LoginRequested(
                //         phone: phoneController.text,
                //       ),
                //     );
              },
              child: Text(
                lang(context).yes,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateButtonState(String? phoneNumber) {
    setState(() {
      _isButtonEnabled =
          phoneNumber != null && phoneNumber.length == maxPhoneLength;
      _isInvalidNumber =
          phoneNumber != null && phoneNumber.length != maxPhoneLength;
    });
  }

  void onCountryChanged(CountryCode countryCode) {
    setState(() {
      selectedCountryCode = countryCode.dialCode!;
      maxPhoneLength = countryPhoneLengths[selectedCountryCode] ?? 10;
      phoneHint = lang(context).phone_length(maxPhoneLength);
      _updateButtonState(phoneController.text);
    });
  }

  String requestCode() {
    String fullPhoneNumber = "$selectedCountryCode${phoneController.text}";
    return fullPhoneNumber;
  }

  Widget _buildSubmitButton(LoginState state) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SizedBox(
          width: _isLoading ? 50 : double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed:
                (!_isButtonEnabled || _isLoading)
                    ? null
                    : () {
                      if (_formKey.currentState?.validate() == true) {
                        _showConfirmationDialog(context);
                      }
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_isLoading ? 25 : 8),
              ),
              padding: EdgeInsets.zero,
            ),
            child:
                _isLoading
                    ? SizedBox(
                      width: 25,
                      height: 25,
                      child: CustomIndicator(
                        color: AppColors.primary,
                        size: 32,
                      ),
                    )
                    : Text(
                      lang(context).submit,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        listener: (context, state) {
          if (state is LoginSuccess) {
            setState(() => _isLoading = false);
            _animationController.reverse();

            if (state.status == 'new_user') {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => SignUpPage(phone: state.phone),
              //     ),
              //   );
              // } else if (state.status == 'existing_user') {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => PasswordPage(
              //         phone: _phoneNumber!,
              //       ),
              //     ),
              //   );
            }
          } else if (state is LoginFailure) {
            setState(() => _isLoading = false);
            _animationController.reverse();

            Flushbar(
              message: state.message,
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
            ).show(context);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    lang(context).submit_phone_number,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CountryCodePicker(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            onChanged: onCountryChanged,
                            initialSelection: 'SY',
                            favorite: const ['+963', '+1', '+44'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                            dialogBackgroundColor: Theme.of(context).cardColor,
                            barrierColor:
                                Theme.of(context).textTheme.titleLarge!.color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(),
                              cursorColor: AppColors.primary,
                              decoration: InputDecoration(
                                hintText: phoneHint,
                                hintStyle: TextStyle(color: Colors.grey),
                                border: const UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 1.9,
                                  ),
                                ),
                                errorText:
                                    _isInvalidNumber
                                        ? lang(context).invalid_phone_number
                                        : null,
                              ),
                              onChanged: (phone) {
                                _phoneNumber = phone;
                                _updateButtonState(_phoneNumber);
                              },
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${phoneController.text.length}/$maxPhoneLength ${lang(context).digits}',
                        style: TextStyle(
                          color:
                              phoneController.text.length > maxPhoneLength
                                  ? Colors.red
                                  : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  _buildSubmitButton(state),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
