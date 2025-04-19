import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Views/Dashboard/place_details_page.dart';
import '../../constants/themes/custom_theme.dart';
import '../indicators/custom_loading_indicator.dart';

class PlaceCard extends StatelessWidget {
  final String title;
  final String location;
  final double rating;
  final int reviewCount;
  final String imageUrl;

  const PlaceCard({
    super.key,
    required this.title,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlaceDetailsPage()),
        );
      },
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
              offset: const Offset(0, 2), // Slightly adjusted shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Image with rounded corners
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  // child: Image.network(
                  //   imageUrl,
                  //   height: 150,
                  //   width: double.infinity,
                  //   fit: BoxFit.cover,
                  // ),
                  // child: Image.network(
                  //   imageUrl,
                  //   height: 150,
                  //   fit: BoxFit.cover,
                  //   errorBuilder: (context, error, stackTrace) {
                  //     return _buildImagePlaceholder();
                  //   },
                  //   loadingBuilder: (context, child, loadingProgress) {
                  //     if (loadingProgress == null) return child;
                  //     return Container(
                  //       height: 150,
                  //       width: double.infinity,
                  //       color: AppColors.primary.withOpacity(0.1),
                  //       child: Center(
                  //         child: CustomLoadingIndicator(
                  //           color: AppColors.primary,
                  //           size: 100,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  child: Image.asset(
                    imageUrl,
                    // height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12), // Increased padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Title
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
                      const SizedBox(height: 8), // Increased spacing
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
                      const SizedBox(height: 8), // Increased spacing
                      // Rating Bar
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 18,
                            itemPadding: const EdgeInsets.symmetric(
                              horizontal: 0.0,
                            ),
                            itemBuilder:
                                (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {
                              // print(rating);
                            },
                          ),
                          const SizedBox(width: 5),
                          // Review Count
                          Text(
                            '($reviewCount reviews)',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: const Center(child: Icon(Icons.image_not_supported, size: 60)),
    );
  }
}
