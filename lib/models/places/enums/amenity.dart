/// Defines common amenities available at a place.
/// يمكنك إضافة المزيد حسب الحاجة
enum Amenity {
  wifi, // واي فاي
  kitchen, // مطبخ
  pool, // مسبح
  parking, // موقف سيارات
  airConditioning, // تكييف هواء
  heating, // تدفئة
  tv, // تلفزيون
  washer, // غسالة ملابس
  dryer, // مجفف ملابس
  iron, // مكواة
  hairDryer, // مجفف شعر
  workspace, // مساحة عمل
  gym, // صالة رياضية
  hotTub, // حوض استحمام ساخن
  evCharger, // شاحن سيارة كهربائية
  breakfastIncluded, // إفطار مشمول
  petsAllowed, // مسموح بالحيوانات الأليفة
  smokingAllowed, // مسموح بالتدخين
}

// --- How to use them in your PlaceInfoModel ---
/*
  // 1. Update the PlaceInfoModel class definition:
  class PlaceInfoModel {
    // ... other fields ...
    final PlaceType placeType; // Instead of final String type;
    final List<Amenity> amenitiesList; // Instead of final List<String> amenities;
    final CancellationPolicyType policyType; // Instead of final String cancellationPolicy;
    // ... other fields ...

    const PlaceInfoModel({
      // ... other constructor parameters ...
      required this.placeType,
      required this.amenitiesList,
      required this.policyType,
      // ... other constructor parameters ...
    });
  }

  // 2. When creating an instance:
  final place = PlaceInfoModel(
    // ... other values ...
    placeType: PlaceType.cabin,
    amenitiesList: [Amenity.wifi, Amenity.kitchen, Amenity.hotTub],
    policyType: CancellationPolicyType.moderate,
    // ... other values ...
  );

  // 3. You can get the string representation if needed:
  // String typeString = place.placeType.name; // Gives "cabin"
*/
