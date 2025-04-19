import 'package:example1/Views/Authentication/signup_page.dart';
import 'package:example1/constants/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryAppIntro extends StatefulWidget {
  const DeliveryAppIntro({super.key});

  static String id = 'DeliveryAppIntro';
  @override
  State<DeliveryAppIntro> createState() => _DeliveryAppIntroState();
}

class _DeliveryAppIntroState extends State<DeliveryAppIntro> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // المحتوى: النصوص وروابط الصور
  final List<Map<String, String>> _pagesContent = [
    {
      'title': 'Fast and Reliable Delivery',
      'image': 'assets/images/delivery-truck.svg',
      'description':
          'Order from your favorite restaurants and stores with fast and reliable delivery.',
    },
    {
      'title': 'Track Your Orders in Real-Time',
      'image': 'assets/images/online-groceries.svg',
      'description':
          'Stay updated with real-time tracking of your orders until they reach your doorstep.',
    },
    {
      'title': 'Enjoy Exclusive Offers',
      'image': 'assets/images/discount.svg',
      'description':
          'Get access to exclusive discounts and offers only available on our app.',
    },
  ];

  void _goToNextPage() {
    if (_currentPage < _pagesContent.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SignUpPage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pagesContent.length,
                itemBuilder: (context, index) {
                  final content = _pagesContent[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          content['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: SvgPicture.asset(content['image']!),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          content['description']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pagesContent.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: _currentPage == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index
                            ? AppColors.primary
                            : Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: _goToNextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  _currentPage == _pagesContent.length - 1
                      ? 'Start Now'
                      : 'Continue',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome to the Delivery App!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
