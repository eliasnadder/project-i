import 'package:flutter/material.dart';
import 'package:example1/Views/Dashboard/place_details_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlaceCard2 extends StatelessWidget {
  final String title;
  final String location;
  final double rating;
  final int reviewCount;
  final List<String> imageUrls;
  final double price;

  const PlaceCard2({
    super.key,
    required this.title,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.imageUrls,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlaceDetailsPage()),
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Horizontal Image Slider
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: imageUrls.length,
                    pageSnapping: true,
                    controller: pageController,

                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildImagePlaceholder();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          Row(
                            children: [
                              RatingBar.builder(
                                initialRating: rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 1,
                                itemSize: 18,
                                itemPadding: const EdgeInsets.symmetric(
                                  horizontal: 0.0,
                                ),
                                itemBuilder:
                                    (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {},
                              ),
                              const SizedBox(width: 5),
                              Text(
                                rating.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Location
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Rating Bar
                      Row(children: [const SizedBox(width: 5)]),
                      const SizedBox(height: 8),
                      // Price
                      Text(
                        '\$$price / night',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white60.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Positioned(
              bottom: 145,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: imageUrls.length,
                  effect: ScrollingDotsEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.grey.withAlpha(200),
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return const SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(child: Icon(Icons.image_not_supported, size: 60)),
    );
  }
}
