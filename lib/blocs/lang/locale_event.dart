
// locale_event.dart
part of 'locale_bloc.dart'; // سيتم إنشاؤه لاحقًا

abstract class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

// حدث لتحميل اللغة المحفوظة عند بدء التشغيل
class LoadLocale extends LocaleEvent {}

// حدث لتغيير اللغة بناءً على اختيار المستخدم
class ChangeLocale extends LocaleEvent {
  final Locale locale;

  const ChangeLocale(this.locale);

  @override
  List<Object> get props => [locale];
}

