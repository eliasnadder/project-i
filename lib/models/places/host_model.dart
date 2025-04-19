
/// Represents the data structure for a host.
class HostModel {
  /// Unique identifier for the host.
  final String id;
  /// Display name of the host.
  final String name;
  /// URL for the host's profile image (optional).
  final String? imageUrl;
  /// Flag indicating if the host is a Superhost.
  final bool isSuperhost;
  /// A short biography or description about the host (optional).
  final String? about;
  /// The date when the host joined the platform.
  final DateTime joinedDate;
  /// Host's response rate (e.g., 0.95 for 95%) (optional).
  final double? responseRate;
  /// Host's typical response time description (e.g., "within an hour") (optional).
  final String? responseTime;
  // You could add more fields like languages spoken, number of listings, etc.

  /// Constructor for creating a HostModel instance.
  const HostModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.isSuperhost,
    this.about,
    required this.joinedDate,
    this.responseRate,
    this.responseTime,
  });

  // Example factory constructor for JSON deserialization (optional)
  // factory HostModel.fromJson(Map<String, dynamic> json) {
  //   return HostModel(
  //     id: json['id'],
  //     name: json['name'],
  //     imageUrl: json['imageUrl'],
  //     isSuperhost: json['isSuperhost'] ?? false,
  //     about: json['about'],
  //     joinedDate: DateTime.parse(json['joinedDate']),
  //     responseRate: (json['responseRate'] as num?)?.toDouble(),
  //     responseTime: json['responseTime'],
  //   );
  // }

  // Example method for JSON serialization (optional)
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'imageUrl': imageUrl,
  //     'isSuperhost': isSuperhost,
  //     'about': about,
  //     'joinedDate': joinedDate.toIso8601String(),
  //     'responseRate': responseRate,
  //     'responseTime': responseTime,
  //   };
  // }
}
