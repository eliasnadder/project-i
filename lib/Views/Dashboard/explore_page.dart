import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../components/cards/place_card.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 48),
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              onTap: () {},
              readOnly: true,
              decoration: InputDecoration(
                hintText: localizations.search,
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ), // Added spacing between search bar and list
          // Expanded to take up remaining space
          Expanded(
            child: ListView(
              children: [
                PlaceCard(
                  title: 'Mountain Retreat',
                  location: 'Snowy Peaks, NSW, Australia',
                  rating: 5.0,
                  reviewCount: 23,
                  imageUrl:
                      'assets/images/pexels-rok-romih-1746122-3312671.jpg',
                ),
                PlaceCard(
                  title: 'Mountain Retreat',
                  location: 'Snowy Peaks, NSW, Australia',
                  rating: 5.0,
                  reviewCount: 23,
                  imageUrl:
                      'assets/images/pexels-rok-romih-1746122-3312671.jpg',
                ),
                PlaceCard(
                  title: 'Cozy Cabin',
                  location: 'Lake Tahoe, CA, USA',
                  rating: 4.8,
                  reviewCount: 15,
                  imageUrl:
                      'assets/images/pexels-czarinah-philline-rayray-2151020930-31460167.jpg',
                ),
                PlaceCard(
                  title: 'Cozy Cabin',
                  location: 'Lake Tahoe, CA, USA',
                  rating: 4.8,
                  reviewCount: 15,
                  imageUrl: 'assets/images/img-3.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
