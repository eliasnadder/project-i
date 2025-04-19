import 'package:flutter/material.dart';
import 'package:example1/constants/themes/custom_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Required for SystemUiOverlayStyle
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaceDetailsPage extends StatefulWidget {
  @override
  _PlaceDetailsPageState createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  // List of placeholder image URLs - replace with your actual image URLs
  final List<String> _imageUrls = [
    'assets/images/pexels-czarinah-philline-rayray-2151020930-31460167.jpg',
    'assets/images/pexels-czarinah-philline-rayray-2151020930-31460167.jpg',
    'assets/images/pexels-czarinah-philline-rayray-2151020930-31460167.jpg',
    'assets/images/pexels-czarinah-philline-rayray-2151020930-31460167.jpg',
    'assets/images/pexels-czarinah-philline-rayray-2151020930-31460167.jpg',
    'assets/images/pexels-czarinah-philline-rayray-2151020930-31460167.jpg',
  ];
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // --- App Bar with Back, Share, Favorite Buttons ---
          SliverAppBar(
            pinned: true, // Keep the app bar visible while scrolling up
            expandedHeight: 300.0, // Initial height for the image area
            backgroundColor:
                Colors.transparent, // Make AppBar transparent initially
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: IconButton(
                    icon: Icon(Icons.share_outlined, color: Colors.black87),
                    onPressed: () {
                      // Handle share action
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.black87),
                    onPressed: () {
                      // Handle favorite action
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // --- Horizontal Image Gallery ---
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _imageUrls.length,
                    onPageChanged: (index) {},
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _imageUrls[index],
                        fit: BoxFit.cover,
                        // Add error handling for images
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey[600],
                              ),
                            ),
                          );
                        },
                        // Add loading indicator
                        // loadingBuilder: (context, child, loadingProgress) {
                        //   if (loadingProgress == null) return child;
                        //   return Center(
                        //     child: CircularProgressIndicator(
                        //       value:
                        //           loadingProgress.expectedTotalBytes != null
                        //               ? loadingProgress.cumulativeBytesLoaded /
                        //                   loadingProgress.expectedTotalBytes!
                        //               : null,
                        //     ),
                        //   );
                        // },
                      );
                    },
                  ),
                  // --- Image Counter ---
                  // Positioned(
                  //   bottom: 16.0,
                  //   right: 16.0,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 12.0,
                  //       vertical: 6.0,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.black.withOpacity(0.6),
                  //       borderRadius: BorderRadius.circular(20.0),
                  //     ),
                  //     child: Text(
                  //       '${_currentPage + 1} / ${_imageUrls.length}',
                  //       style: TextStyle(color: Colors.white, fontSize: 12.0),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        height: 20,
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: _imageUrls.length,
                          effect: ScrollingDotsEffect(
                            activeDotColor: Colors.white,
                            dotColor: Colors.black.withAlpha(70),
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Content Below Images ---
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // --- Title ---
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Waterfront / Lots of Privacy / Free Parking!',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),

                    // --- Location & Guest Info ---
                    Text(
                      'Entire guest house in Amsterdam, Netherlands',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 8.0),
                    _buildBasicFeatures(),
                    SizedBox(height: 8.0),

                    // --- Rating ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.black, size: 18.0),
                        SizedBox(width: 4.0),
                        Text(
                          '4.92',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          '(976 reviews)',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),

                // --- Rare Find Section ---
                Row(
                  children: [
                    Icon(
                      Icons.diamond_outlined,
                      color: Colors.pink,
                      size: 36.0,
                    ), // Placeholder icon
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'This is a rare find',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            "Karina's place is usually fully booked.",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),

                // --- Host Info ---
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24.0,
                      backgroundImage: NetworkImage(
                        'https://placehold.co/100x100/E0E0E0/grey?text=Host',
                      ), // Placeholder Host Image
                      backgroundColor: Colors.grey[300],
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hosted by Karina',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Superhost · 9 years hosting',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),

                // --- Check-in Info ---
                Row(
                  children: [
                    Icon(
                      Icons.key_outlined,
                      color: Colors.black87,
                      size: 24.0,
                    ), // Placeholder icon
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        '24-hour self check-in',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),

                // Add more sections as needed (description, amenities, map, etc.)
                SizedBox(height: 200),
              ]),
            ),
          ),
        ],
      ),
      // --- Bottom Navigation Bar (Price & Reserve) ---
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primary.withAlpha(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // --- Price ---
              Column(
                mainAxisSize: MainAxisSize.min, // Take minimum space vertically
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '£118 / night', // Use appropriate currency symbol
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '7-12 Nov', // Placeholder dates
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              // --- Reserve Button ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(localizations.reserve),
                onPressed: () {
                  Navigator.pushNamed(context, '/confirm-and-pay');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the basic features section
  Widget _buildBasicFeatures() {
    return Row(
      // Using spaceAround for slightly different spacing
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFeatureItem(Icons.home_outlined, 'House'),
        _buildFeatureItem(Icons.bed_outlined, '2 beds'),
        _buildFeatureItem(Icons.bathtub_outlined, '1 bath'),
        _buildFeatureItem(Icons.garage_outlined, '1 garage'),
      ],
    );
  }

  // Helper for feature items (reused)
  Widget _buildFeatureItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 28.0, color: Colors.grey[700]),
        const SizedBox(height: 4.0),
        Text(label, style: TextStyle(fontSize: 14.0, color: Colors.grey[600])),
      ],
    );
  }
}
