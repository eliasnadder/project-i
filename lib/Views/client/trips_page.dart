import 'package:flutter/material.dart';
import 'package:example1/constants/themes/custom_theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});
  AppLocalizations lang(BuildContext context) => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: AppBar(
              title: Text(
                lang(context).trips,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: SvgPicture.asset('assets/illustrations/trip.svg'),
                ),
                Text(
                  lang(context).no_trips,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.primary),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  child: Text(
                    lang(context).start_reserve,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
