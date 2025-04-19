import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlaceDetailsPage2 extends StatefulWidget {
  const PlaceDetailsPage2({super.key});

  @override
  State<PlaceDetailsPage2> createState() => _PlaceDetailsPage2State();
}

class _PlaceDetailsPage2State extends State<PlaceDetailsPage2> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _imageUrls = [
    'assets/images/pexels-czarinah-philline-rayray-2151020930-31460167.jpg',
    'assets/images/pexels-czarinah-philline-rayray-2151020930-31460167.jpg',
    'assets/images/pexels-czarinah-philline-rayray-2151020930-31460167.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: <Widget>[
                // Image Carousel
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _imageUrls.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder:
                        (context, index) =>
                            Image.asset(_imageUrls[index], fit: BoxFit.cover),
                  ),
                ),

                // // Gradient Overlay
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.5,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //       colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                //     ),
                //   ),
                // ),

                // Back Button
                Positioned(
                  top: 40,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.black,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: _imageUrls.length,
                      effect: ScrollingDotsEffect(
                        activeDotColor: Colors.white,
                        dotColor: Colors.grey,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ),
                ),

                // Content Card
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Text(''),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Mountain Retreat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: Colors.black87,
                    ),
                  ),
                  const Text(
                    'Snowy Peaks, NSW, Australia',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder:
                        (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '5.0 (23 reviews)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildIconText(context, Icons.home, 'House'),
                      _buildIconText(context, Icons.bed, '2 beds'),
                      _buildIconText(context, Icons.bathtub, '1 bath'),
                      _buildIconText(context, Icons.garage, '1 garage'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Experience the wonders of nature as you hike through the snow-capped mountains and fish in the nearby river. This newly built cabin sits high in the mountains, offering breathtaking views that stretch as far as the eye can see.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontFamily: 'Inter',
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Book now',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Text(
                  '\$299.00 / night',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(BuildContext context, IconData icon, String text) {
    return Column(
      children: <Widget>[
        Icon(icon, size: 28, color: Colors.blue),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
