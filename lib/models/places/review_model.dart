import 'dart:core'; // Provides DateTime, String, int, double, bool, List, Map

/// Represents the data structure for a user review.
class ReviewModel {
  /// Unique identifier for the review.
  final String id;
  /// Identifier of the place being reviewed.
  final String placeId;
  /// Identifier of the user who wrote the review.
  final String userId;
  /// Display name of the user who wrote the review.
  final String userName;
  /// URL for the user's profile image (optional).
  final String? userImageUrl;
  /// Rating score given by the user (e.g., out of 5).
  final double rating;
  /// The text content of the review.
  final String comment;
  /// The date and time when the review was submitted.
  final DateTime date;

  /// Constructor for creating a ReviewModel instance.
  const ReviewModel({
    required this.id,
    required this.placeId,
    required this.userId,
    required this.userName,
    this.userImageUrl,
    required this.rating,
    required this.comment,
    required this.date,
  });

  // Example factory constructor for JSON deserialization (optional)
  // factory ReviewModel.fromJson(Map<String, dynamic> json) {
  //   return ReviewModel(
  //     id: json['id'],
  //     placeId: json['placeId'],
  //     userId: json['userId'],
  //     userName: json['userName'],
  //     userImageUrl: json['userImageUrl'],
  //     rating: (json['rating'] as num).toDouble(), // Handle potential int/double
  //     comment: json['comment'],
  //     date: DateTime.parse(json['date']), // Assumes ISO 8601 format
  //   );
  // }

  // Example method for JSON serialization (optional)
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'placeId': placeId,
  //     'userId': userId,
  //     'userName': userName,
  //     'userImageUrl': userImageUrl,
  //     'rating': rating,
  //     'comment': comment,
  //     'date': date.toIso8601String(),
  //   };
  // }
}
