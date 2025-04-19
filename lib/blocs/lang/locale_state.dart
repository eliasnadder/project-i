// locale_state.dart
part of 'locale_bloc.dart'; // سيتم إنشاؤه لاحقًا

// الحالة الأساسية
abstract class LocaleState extends Equatable {
  final Locale? locale;

  const LocaleState(this.locale);

  @override
  List<Object?> get props => [locale];
}

// الحالة الأولية قبل تحميل اللغة
class LocaleInitial extends LocaleState {
  const LocaleInitial() : super(null);
}

// الحالة بعد تحميل أو تغيير اللغة
class LocaleLoaded extends LocaleState {
  const LocaleLoaded(Locale locale) : super(locale);
}

