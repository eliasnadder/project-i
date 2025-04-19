import 'package:example1/Views/Authentication/email_page.dart';
import 'package:example1/Views/Authentication/otp_page.dart';
import 'package:example1/Views/Authentication/phone_page.dart';
import 'package:example1/Views/Authentication/profile_photo_page.dart';
import 'package:example1/start_page.dart';
import 'package:flutter/material.dart';
import 'package:example1/Views/Authentication/login_page.dart';
import 'package:example1/Views/Dashboard/home_screen.dart';
import 'package:example1/components/indicators/custom_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Views/Authentication/signup_page.dart';
import 'Views/Dashboard/confirm_and_pay_page.dart';
import 'Views/client/messages_page.dart';
import 'Views/client/profile_page.dart';
import 'Views/client/settings/lang_page.dart';
import 'Views/client/trips_page.dart';
import 'Views/client/wishlist_page.dart';
import 'blocs/lang/locale_bloc.dart';
import 'blocs/users/Auth/login_bloc.dart';
import 'constants/themes/custom_theme.dart';

void main() async {
  // التأكد من تهيئة Flutter bindings قبل استخدام SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();
  // قراءة SharedPreferences بشكل غير متزامن
  final prefs = await SharedPreferences.getInstance();
  // تشغيل التطبيق مع توفير الـ Bloc

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => LoginBloc())],
      child: MyApp(preferences: prefs),
    ),
  );
}

class MyApp extends StatefulWidget {
  final SharedPreferences preferences;

  const MyApp({super.key, required this.preferences});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleBloc(widget.preferences)..add(LoadLocale()),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          if (state is LocaleInitial || state.locale == null) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CustomIndicator(color: AppColors.primary, size: 100),
                ),
              ),
            );
          }
          ThemeData lightTheme = AppColors.lightTheme(context, state.locale!);
          return MaterialApp(
            theme: lightTheme,
            locale: state.locale,
            debugShowCheckedModeBanner: false,
            supportedLocales: const [
              Locale('en'), // English
              Locale('ar'), // Arabic
            ],
            // تحديد مندوبي الترجمة
            localizationsDelegates: const [
              AppLocalizations.delegate, // المندوب الخاص بتطبيقك (سيتم إنشاؤه)
              GlobalMaterialLocalizations
                  .delegate, // للترجمات الأساسية للماتيريال ديزاين
              GlobalWidgetsLocalizations
                  .delegate, // للترجمات الخاصة باتجاه النص والعناصر الأخرى
              GlobalCupertinoLocalizations
                  .delegate, // للترجمات الخاصة بكوبرتينو (iOS)
            ],
            routes: {
              '/login': (context) => LoginPage(),
              SignUpPage.id: (context) => SignUpPage(),
              '/lang': (context) => LangPage(),
              '/trips': (context) => TripsPage(),
              '/home': (context) => HomeScreen(),
              '/profile': (context) => ProfilePage(),
              '/messages': (context) => MessagesPage(),
              '/wishlist': (context) => WishlistPage(),
              '/confirm-and-pay': (context) => ConfirmAndPayScreen(),
              PhonePage.id: (context) => PhonePage(),
              EmailPage.id: (context) => EmailPage(),
              ProfilePhotoPage.id: (context) => ProfilePhotoPage(),
              OTPPage.id: (context) => OTPPage(),
            },
            home: StartPage(),
          );
        },
      ),
    );
  }
}
