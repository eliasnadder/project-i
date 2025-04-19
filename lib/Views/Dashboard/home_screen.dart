import 'package:flutter/material.dart';
import 'package:example1/components/cards/place_card2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<PlaceCard2> places = [
    PlaceCard2(
      title: 'Mountain Retreat',
      location: 'Snowy Peaks, NSW, Australia',
      rating: 4.9,
      reviewCount: 23,
      imageUrls: [
        'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80', // رابط صورة كندا
        'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80', // رابط صورة كندا
        'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80', // رابط صورة كندا
      ],
      price: 154,
    ),
    PlaceCard2(
      title: 'Cozy Cabin',
      location: 'Lake Tahoe, CA, USA',
      rating: 3,
      reviewCount: 15,
      imageUrls: [
        'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80', // رابط صورة كندا
        'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80', // رابط صورة كندا
      ],
      price: 200,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      // استخدام CustomScrollView للسماح بسلوكيات تمرير مخصصة
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 75,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
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
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionTitle(localizations.best_destinations),
                _buildDestinationList(),
                const SizedBox(height: 20),
                _buildSectionTitle(localizations.best_hotels),
                _buildHotelList(),
                const SizedBox(height: 20),
                _buildSectionTitle(localizations.suggested_places),
                _buildPlaceCardList(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت لبناء عنوان القسم
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  // ويدجت لبناء قائمة الوجهات (عرض أفقي)
  Widget _buildDestinationList() {
    return SizedBox(
      height: 220.0, // ارتفاع صف الوجهات
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          // بطاقة وجهة كندا
          _buildDestinationCard(
            'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
            'كندا',
          ),
          const SizedBox(width: 16),
          _buildDestinationCard(
            'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
            'إيطاليا',
          ),
          const SizedBox(width: 16),
          _buildDestinationCard(
            'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
            'إيطاليا',
          ),
          const SizedBox(width: 16),
          _buildDestinationCard(
            'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
            'إيطاليا',
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  // ويدجت لبناء قائمة الفنادق (عرض أفقي) - مشابه لقائمة الوجهات
  Widget _buildHotelList() {
    return SizedBox(
      height: 220.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          _buildDestinationCard(
            'https://images.unsplash.com/photo-1534067783941-51c9c23ecefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
            'فندق كندا',
          ),
          const SizedBox(width: 16),
          _buildDestinationCard(
            'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
            'فندق إيطاليا',
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  // ويدجت لبناء بطاقة الوجهة/الفندق
  Widget _buildDestinationCard(String imageUrl, String name) {
    return SizedBox(
      width: 160.0,
      child: Card(
        // شكل البطاقة مع حواف دائرية
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        // قص المحتوى ليناسب الحواف الدائرية
        clipBehavior: Clip.antiAlias,
        elevation: 4.0, // إضافة ظل خفيف للبطاقة
        child: Stack(
          alignment: Alignment.bottomLeft, // محاذاة النص إلى الأسفل واليسار
          children: [
            Image.network(
              imageUrl,
              height: 220.0,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 220.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.broken_image, color: Colors.grey[600]),
                  ),
                );
              },
            ),
            // طبقة تدرج لوني فوق الصورة لجعل النص أكثر وضوحًا
            Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // New Widget for PlaceCard List
  Widget _buildPlaceCardList() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ), // Adjust padding as needed
      child: Column(children: places.map((place) => place).toList()),
    );
  }
}
