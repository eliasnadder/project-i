import 'package:flutter/material.dart';
import 'package:example1/blocs/lang/locale_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LangPage extends StatelessWidget {
  const LangPage({super.key});
  AppLocalizations lang(BuildContext context) => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          children: [
            AppBar(title: Text(lang(context).language)),
            _buildSettingsItem(
              context,
              lang(context).english,
              () => context.read<LocaleBloc>().add(
                const ChangeLocale(Locale('en')),
              ),
            ),
            _buildSettingsItem(
              context,
              lang(context).arabic,
              () => context.read<LocaleBloc>().add(
                const ChangeLocale(Locale('ar')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Text(title, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Divider(color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }
}
