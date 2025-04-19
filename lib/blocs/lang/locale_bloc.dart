// locale_bloc.dart
import 'dart:async';
import 'dart:ui'; // لاستخدام Locale
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// تعريف الأجزاء للوصول للأحداث والحالات
part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final SharedPreferences _preferences;
  static const String _kLocaleKey = 'app_locale'; // نفس المفتاح المستخدم سابقًا

  LocaleBloc(this._preferences) : super(const LocaleInitial()) {
    // تسجيل معالجات الأحداث
    on<LoadLocale>(_onLoadLocale);
    on<ChangeLocale>(_onChangeLocale);
  }

  // معالج حدث تحميل اللغة
  Future<void> _onLoadLocale(
    LoadLocale event,
    Emitter<LocaleState> emit,
  ) async {
    final String? languageCode = _preferences.getString(_kLocaleKey);
    Locale loadedLocale;
    if (languageCode != null && languageCode.isNotEmpty) {
      loadedLocale = Locale(languageCode);
    } else {
      // اللغة الافتراضية إذا لم يتم الحفظ من قبل
      loadedLocale = const Locale('en');
      // حفظ اللغة الافتراضية للمرة الأولى (اختياري)
      // await _preferences.setString(_kLocaleKey, loadedLocale.languageCode);
    }
    // إصدار الحالة الجديدة مع اللغة المحملة
    emit(LocaleLoaded(loadedLocale));
  }

  // معالج حدث تغيير اللغة
  Future<void> _onChangeLocale(
    ChangeLocale event,
    Emitter<LocaleState> emit,
  ) async {
    // التحقق إذا كانت اللغة مختلفة بالفعل
    if (state.locale == event.locale) return;

    // حفظ اللغة الجديدة في SharedPreferences
    await _preferences.setString(_kLocaleKey, event.locale.languageCode);
    // إصدار الحالة الجديدة مع اللغة المحدثة
    emit(LocaleLoaded(event.locale));
  }
}
