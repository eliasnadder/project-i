import 'package:flutter/material.dart';
import 'package:example1/constants/themes/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  AppLocalizations lang(BuildContext context) => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: AppBar(
              title: Text(
                lang(context).wishlists,
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
                  child: SvgPicture.asset('assets/illustrations/wishlist.svg'),
                ),
                Text(
                  lang(context).empty_wishlist,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
