import 'package:flutter/material.dart';
import 'package:example1/components/cards/place_card2.dart'; // تأكد من وجود هذا الملف والمكون
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // تأكد من إعداد الترجمة

// افترض وجود هذا الملف والمكون أو قم بإنشائه
// import '../../components/bars/custom_tabbar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // بيانات الأماكن (يمكنك استخدامها لاحقًا في إحدى علامات التبويب)
  final List<PlaceCard2> places = [
    PlaceCard2(
      title: 'Mountain Retreat',
      location: 'Snowy Peaks, NSW, Australia',
      rating: 4.9,
      reviewCount: 23,
      imageUrls: [
        'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
        'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
        'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      ],
      price: 154,
    ),
    PlaceCard2(
      title: 'Cozy Cabin',
      location: 'Lake Tahoe, CA, USA',
      rating: 3,
      reviewCount: 15,
      imageUrls: [
        'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
        'https://images.unsplash.com/photo-1503614472-8c93d56e92ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      ],
      price: 200,
    ),
  ];

  TabController? _tabController;
  List<Widget> _tabs = []; // قائمة بعناوين علامات التبويب

  @override
  void initState() {
    super.initState();
    // لا تقم بتهيئة TabController هنا إذا كان يعتمد على السياق/الترجمة
    print("initState: TabController is null initially.");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // تعريف عناوين علامات التبويب باستخدام الترجمة إذا لزم الأمر
    // استخدم AppLocalizations هنا إذا كانت العناوين مترجمة
    final localizations = AppLocalizations.of(context);
    final newTabs = [
      // يمكنك استخدام localizations?.yourTabTitle ?? 'Default Title'
      Tab(text: localizations?.main ?? 'Main'), // مثال لاستخدام الترجمة
      Tab(text: localizations?.estates ?? 'Estates'),
      Tab(text: localizations?.cars ?? 'Cars'),
    ];

    // التحقق مما إذا تغيرت علامات التبويب أو إذا لم تتم تهيئة وحدة التحكم
    if (_tabs.length != newTabs.length || _tabController == null) {
      print("didChangeDependencies: Initializing/Updating TabController.");
      _tabs = newTabs; // تحديث قائمة علامات التبويب

      // التخلص من وحدة التحكم السابقة *قبل* إنشاء واحدة جديدة، إذا كانت موجودة
      _tabController?.removeListener(_handleTabChange);
      _tabController?.dispose();

      // إنشاء وحدة التحكم الجديدة
      _tabController = TabController(length: _tabs.length, vsync: this);

      // إضافة المستمع إلى وحدة التحكم الجديدة
      _tabController?.addListener(_handleTabChange);

      // إعادة البناء بعد تهيئة/تحديث وحدة التحكم
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  void _handleTabChange() {
    if (_tabController != null && !_tabController!.indexIsChanging && mounted) {
      print("Tab changed to: ${_tabController!.index}");
      // قم بتحديث الحالة هنا إذا لزم الأمر عند تغيير علامة التبويب
      setState(() {
        // يمكنك تغيير شيء ما بناءً على _tabController!.index
      });
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // التحقق من تهيئة TabController. إذا لم يكن كذلك، أظهر مؤشر تحميل.
    if (_tabController == null) {
      print("build: TabController is null, showing loading indicator.");
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    print("build: TabController is ready, building UI.");

    // لا حاجة لـ DefaultTabController هنا لأننا ندير TabController بأنفسنا
    return Scaffold(
      body: SafeArea(
        // استخدام NestedScrollView لدمج AppBar القابل للطي مع TabBar و TabBarView
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // هذه هي الأجزاء التي ستظهر فوق محتوى التمرير الرئيسي (TabBarView)
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 100.0, // يمكنك تعديل الارتفاع حسب الحاجة
                floating: false, // يبقى شريط البحث مرئيًا عند التمرير لأعلى
                pinned: true, // يبقى TabBar مثبتًا في الأعلى
                elevation: 1, // ظل خفيف
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: Size(75, 75),
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 8.0),
                            Text(
                              localizations.search,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TabBar(
                        controller: _tabController!,
                        tabs: _tabs,
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorWeight: 3.0,
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          // TabBarView هو الجسم الرئيسي لـ NestedScrollView
          // سيعرض المحتوى المقابل لكل علامة تبويب
          body: TabBarView(
            controller: _tabController!,
            children: <Widget>[
              // المحتوى لعلامة التبويب الأولى (الرئيسية)
              _buildMainTabContent(localizations),
              // المحتوى لعلامة التبويب الثانية (العقارات)
              _buildEstatesTabContent(localizations),
              // المحتوى لعلامة التبويب الثالثة (السيارات)
              _buildCarsTabContent(localizations),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================
  // ويدجات محتوى علامات التبويب
  // ============================================

  // ويدجت لمحتوى علامة التبويب الرئيسية
  Widget _buildMainTabContent(AppLocalizations localizations) {
    // استخدام ListView للحفاظ على قابلية التمرير للمحتوى الطويل
    return ListView(
      padding: EdgeInsets.zero, // إزالة الحشو الافتراضي لـ ListView
      children: <Widget>[
        _buildSectionTitle(localizations.best_destinations),
        _buildDestinationList(),
        const SizedBox(height: 20),
        _buildSectionTitle(localizations.best_hotels),
        _buildHotelList(),
        const SizedBox(height: 20),
        _buildSectionTitle(localizations.suggested_places),
        _buildPlaceCardList(),
        const SizedBox(height: 20), // مسافة إضافية في الأسفل
      ],
    );
  }

  // ويدجت لمحتوى علامة التبويب "عقارات" (مثال)
  Widget _buildEstatesTabContent(AppLocalizations localizations) {
    return Center(
      child: Text(
        'Estates Content Here', // استخدم الترجمة
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  // ويدجت لمحتوى علامة التبويب "سيارات" (مثال)
  Widget _buildCarsTabContent(AppLocalizations localizations) {
    return Center(
      child: Text(
        'Cars Content Here', // استخدم الترجمة
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  // ============================================
  // الويدجات المساعدة (كما كانت لديك)
  // ============================================

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDestinationList() {
    // ... (الكود الخاص بك لقائمة الوجهات كما هو)
    return SizedBox(
      height: 220.0, // ارتفاع صف الوجهات
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
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

  Widget _buildHotelList() {
    // ... (الكود الخاص بك لقائمة الفنادق كما هو)
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

  Widget _buildDestinationCard(String imageUrl, String name) {
    // ... (الكود الخاص بك لبطاقة الوجهة كما هو)
    return SizedBox(
      width: 160.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 4.0,
        child: Stack(
          alignment: Alignment.bottomLeft,
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

  Widget _buildPlaceCardList() {
    // ... (الكود الخاص بك لقائمة PlaceCard2 كما هو)
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(children: places.map((place) => place).toList()),
    );
  }
}
