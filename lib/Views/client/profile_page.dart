import 'package:flutter/material.dart';
import 'package:example1/Views/client/settings/lang_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  AppLocalizations lang(BuildContext context) => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    final localizations = lang(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: ListView(
          children: [
            AppBar(
              title: Text(
                localizations.profile,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.black87,
                    size: 28,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            _buildProfileHeader(context),
            _buildAirbnbYourHome(context),
            _buildSettingsSection(context),
            _buildHostingSection(context),
            _buildReferralsAndCreditsSection(context),
            _buildSupportSection(context),
            _buildLegalSection(context),
            _buildLogoutButton(context),
            _buildVersionInfo(context), // Added version info
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://placehold.co/80x80/EEE/31343C?text=E&font=Roboto',
                  ), // Placeholder
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elias',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ), // Apply font
                    ),
                    Text(
                      lang(context).show_profile,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ), // Apply font
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    // Navigate to profile
                  },
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[300]),
        ],
      ),
    );
  }

  Widget _buildAirbnbYourHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang(context).hosting_title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ), // Apply font
                        ),
                        Text(
                          lang(context).hosting_text,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            overflow: TextOverflow.fade,
                          ), // Apply font
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 100,
                    height: 80,
                    child: SvgPicture.asset('assets/illustrations/home.svg'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Divider(color: Colors.grey[300]),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return _buildSectionTitle(context, lang(context).settings, [
      _buildSettingsItem(
        context,
        lang(context).personal_info,
        Icons.person_outline,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).login_security,
        Icons.lock_outline,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).payments_payouts,
        Icons.payment_outlined,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).accessibility,
        Icons.accessibility_outlined,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).taxes,
        Icons.monetization_on_outlined,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).translation,
        Icons.g_translate_outlined,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).notifications,
        Icons.notifications_none,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).privacy_sharing,
        Icons.share,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).travel_work,
        Icons.work_outline,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).language,
        Icons.language_outlined,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LangPage()),
        ),
      ),
    ]);
  }

  Widget _buildHostingSection(BuildContext context) {
    return _buildSectionTitle(context, lang(context).hosting, [
      _buildSettingsItem(
        context,
        lang(context).list_your_space,
        Icons.home_outlined,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).learn_about_hosting,
        Icons.info_outline,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).host_an_experience,
        Icons.event_outlined,
        () {},
      ),
    ]);
  }

  Widget _buildReferralsAndCreditsSection(BuildContext context) {
    return _buildSectionTitle(context, lang(context).referrals_creadits, [
      _buildSettingsItem(
        context,
        lang(context).gift_cards,
        Icons.card_giftcard,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).send_or_redeem_gift_card,
        Icons.redeem,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).refer_a_host,
        Icons.group_add,
        () {},
      ),
    ]);
  }

  Widget _buildSupportSection(BuildContext context) {
    return _buildSectionTitle(context, lang(context).support, [
      _buildSettingsItem(
        context,
        lang(context).visit_help_center,
        Icons.help_outline,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).get_help_safety_issue,
        Icons.warning_amber_outlined,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).how_airbnb_works,
        Icons.lightbulb_outline,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).give_us_feedback,
        Icons.feedback_outlined,
        () {},
      ),
    ]);
  }

  Widget _buildLegalSection(BuildContext context) {
    return _buildSectionTitle(context, lang(context).legal, [
      _buildSettingsItem(
        context,
        lang(context).terms_service,
        Icons.book_outlined,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).privacy_policy,
        Icons.shield_outlined,
        () {},
      ),
      _buildSettingsItem(
        context,
        lang(context).open_source_licenses,
        Icons.code_outlined,
        () {},
      ),
    ]);
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    List<Widget> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ), // Apply font
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    IconData icon,
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
                  Icon(icon),
                  const SizedBox(width: 16),
                  Text(title, style: const TextStyle(fontSize: 16)),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            Divider(color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextButton(
        onPressed: () {
          // Handle logout
        },
        style: TextButton.styleFrom(foregroundColor: Colors.red),
        child: Text(
          lang(context).logout,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ), // Apply font
        ),
      ),
    );
  }

  Widget _buildVersionInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Center(
        child: Text(
          '${lang(context).version} 23.42.2', // Hardcoded version.  In a real app, get this dynamically.
          style: TextStyle(fontSize: 12, color: Colors.grey), // Apply font
        ),
      ),
    );
  }
}
