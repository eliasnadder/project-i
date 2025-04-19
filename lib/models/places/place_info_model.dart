import 'package:flutter/material.dart'; // Required for DateTimeRange if used

// TODO: Define related models if needed (e.g., ReviewModel, HostModel)
// class ReviewModel { ... }
// class HostModel { ... }

// TODO: Define enums for types like PlaceType, CancellationPolicyType, Amenity
// enum PlaceType { apartment, cabin, room, hotel }
// enum CancellationPolicyType { flexible, moderate, strict }
// enum Amenity { wifi, kitchen, pool, parking, ac }

/// Represents the data structure for information about a place.
class PlaceInfoModel {
  /// --- Basic Information ---
  /// Unique identifier for the place.
  final String id;
  /// Name of the place (e.g., "Soul Escape").
  final String name;
  /// Detailed description of the place.
  final String description;
  /// Type of the place (e.g., "Entire cabin"). Consider using an enum PlaceType.
  final String type;
  /// List of image URLs for the place.
  final List<String> images;

  /// --- Location ---
  /// Full text address.
  final String address;
  /// Street address (optional).
  final String? street;
  /// City.
  final String city;
  /// State or Province (optional).
  final String? stateProvince;
  /// Postal code (optional).
  final String? postalCode;
  /// Country.
  final String country;
  /// Geographic latitude.
  final double latitude;
  /// Geographic longitude.
  final double longitude;

  /// --- Booking & Price Details ---
  /// Price per night.
  final double pricePerNight;
  /// Currency code (e.g., "USD", "GBP").
  final String currency;
  /// Service fee (optional).
  final double? serviceFee;
  /// Cleaning fee (optional).
  final double? cleaningFee;
  /// Map of other additional fees (optional).
  final Map<String, double>? otherFees;
  /// List of available date ranges for booking (optional).
  final List<DateTimeRange>? availability;
  /// Minimum number of nights required for booking.
  final int minNights;
  /// Maximum number of nights allowed for booking (optional).
  final int? maxNights;
  /// Description or type of the cancellation policy. Consider using an enum CancellationPolicyType.
  final String cancellationPolicy;

  /// --- Ratings & Reviews ---
  /// Average rating score.
  final double averageRating;
  /// Total number of reviews.
  final int reviewCount;
  /// List of detailed reviews (optional, requires ReviewModel).
  // final List<ReviewModel>? reviews;

  /// --- Features & Amenities ---
  /// Maximum number of guests allowed.
  final int capacity;
  /// Number of bedrooms.
  final int bedrooms;
  /// Number of beds.
  final int beds;
  /// Number of bathrooms.
  final int bathrooms;
  /// List of available amenities (e.g., "Wifi", "Kitchen"). Consider using a List<Amenity>.
  final List<String> amenities;

  /// --- Host Information ---
  /// Unique identifier for the host.
  final String hostId;
  /// Name of the host.
  final String hostName;
  /// Flag indicating if the host is a Superhost.
  final bool isSuperhost;
  /// URL for the host's profile image (optional).
  final String? hostImageUrl;

  /// --- Rules & Instructions ---
  /// List of house rules.
  final List<String> houseRules;
  /// Check-in time (e.g., "3:00 PM"). Consider using DateTime or TimeOfDay.
  final String checkInTime;
  /// Check-out time (e.g., "11:00 AM"). Consider using DateTime or TimeOfDay.
  final String checkOutTime;

  /// Constructor for creating a PlaceInfoModel instance.
  const PlaceInfoModel({
    // Basic Info
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.images,
    // Location
    required this.address,
    this.street,
    required this.city,
    this.stateProvince,
    this.postalCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    // Booking & Price
    required this.pricePerNight,
    required this.currency,
    this.serviceFee,
    this.cleaningFee,
    this.otherFees,
    this.availability,
    required this.minNights,
    this.maxNights,
    required this.cancellationPolicy,
    // Ratings & Reviews
    required this.averageRating,
    required this.reviewCount,
    // this.reviews, // Uncomment if using ReviewModel
    // Features & Amenities
    required this.capacity,
    required this.bedrooms,
    required this.beds,
    required this.bathrooms,
    required this.amenities,
    // Host Info
    required this.hostId,
    required this.hostName,
    required this.isSuperhost,
    this.hostImageUrl,
    // Rules & Instructions
    required this.houseRules,
    required this.checkInTime,
    required this.checkOutTime,
  });

  // Example of a factory constructor for creating from JSON (if needed)
  // factory PlaceInfoModel.fromJson(Map<String, dynamic> json) {
  //   return PlaceInfoModel(
  //     id: json['id'],
  //     name: json['name'],
  //     // ... parse all other fields
  //   );
  // }

  // Example of a method to convert to JSON (if needed)
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     // ... add all other fields
  //   };
  // }
}
