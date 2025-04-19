import 'phone_page.dart';
import 'package:flutter/material.dart';
import '../../blocs/lang/locale_bloc.dart';
import '../../constants/themes/custom_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/fields/custom_field.dart';

// Login Page Widget
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final TextEditingController emailController = TextEditingController();

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

        actions: [
          DropdownButton<Locale>(
            underline: const SizedBox(),
            icon: const Icon(Icons.language, color: Colors.black),
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                context.read<LocaleBloc>().add(ChangeLocale(newLocale));
              }
            },
            items:
                AppLocalizations.supportedLocales.map<DropdownMenuItem<Locale>>(
                  (Locale locale) {
                    final String languageName =
                        locale.languageCode == 'en'
                            ? 'English'
                            : (locale.languageCode == 'ar'
                                ? 'العربية'
                                : locale.languageCode);
                    return DropdownMenuItem<Locale>(
                      value: locale,
                      child: Text(languageName),
                    );
                  },
                ).toList(),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              localizations.login,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            CustomField(
              name: localizations.email,
              filled: true,
              errorMessage: localizations.email_error,
              controller: emailController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
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
                localizations.continue_email,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32.0),
            Row(
              children: <Widget>[
                Expanded(child: Divider(color: Colors.grey.shade400)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    localizations.or,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey.shade400)),
              ],
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: Image.asset(
                'assets/Symbol.png',
                height: 24.0,
                // errorBuilder: (context, error, stackTrace) {
                //   return const Icon(Icons.g_mobiledata, size: 28.0);
                // },
              ),
              label: Text(
                localizations.continue_g,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // TODO: تنفيذ منطق تسجيل الدخول باستخدام جوجل هنا
                print('Google Sign-In button pressed');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black87,
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                elevation: 2,
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              icon: Icon(Icons.phone, size: 28.0),
              label: Text(
                localizations.continue_phone,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pushNamed(context, PhonePage.id),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black87,
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
