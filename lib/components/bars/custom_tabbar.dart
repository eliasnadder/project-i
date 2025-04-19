// --- CustomTabBar Component (Modified to accept external controller) ---
// Ideally, this component should be in its own file and imported.
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  // List of tab titles passed to the component
  final List<String> tabs;
  // The TabController is now required and passed from the parent
  final TabController controller;
  // Optional callback function when a tab is selected
  final ValueChanged<int>? onTabSelected;

  // Constructor requiring the controller and list of tabs
  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.controller,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final unselectedColor = Colors.black;
    final selectedColor = Colors.white;
    final indicatorColor = Colors.black;
    final unselectedTabBackgroundColor = Colors.grey[200];

    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TabBar(
        controller: controller, // Use the provided controller
        // --- Styling the selected tab indicator ---
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25), // Fully rounded corners
          color: indicatorColor, // Use black color for selected background
        ),
        indicatorSize:
            TabBarIndicatorSize.tab, // Make indicator fill the tab space
        indicatorPadding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 4,
        ), // Padding *around* the indicator
        // --- Styling the labels ---
        labelColor: selectedColor,
        unselectedLabelColor: unselectedColor,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        // --- Remove the default divider ---
        dividerColor: Colors.transparent,
        // Pass the onTap callback
        onTap: onTabSelected,

        tabs:
            tabs.map((String title) {
              return Tab(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    // Set background for the *entire* tab area (will be overridden by indicator when selected)
                    color: unselectedTabBackgroundColor,
                  ),
                  child: Text(title),
                ),
              );
            }).toList(),
        labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        tabAlignment: TabAlignment.start,
        isScrollable: true, // Allow scrolling if tabs exceed available width
      ),
    );
  }
}

// --- End CustomTabBar Component ---
