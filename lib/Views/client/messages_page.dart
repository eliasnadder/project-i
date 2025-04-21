// --- Your MessagesPage Widget ---
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/bars/custom_tabbar.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage>
    with SingleTickerProviderStateMixin {
  // Make TabController nullable, it will be initialized in didChangeDependencies
  TabController? _tabController;
  // Initialize tabs list directly
  List<String> _tabs = []; // To hold tab titles, initialized empty

  @override
  void initState() {
    super.initState();
    // DO NOT initialize TabController here if its length depends on context/localizations
    print("initState: TabController is null initially.");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Define tab titles using localizations
    final newTabs = ['Chats', 'Calls'];

    // Check if tabs have changed or if controller is not initialized
    // This ensures controller is created only once or if tab length changes.
    if (_tabs.length != newTabs.length || _tabController == null) {
      print("didChangeDependencies: Initializing/Updating TabController.");
      _tabs = newTabs; // Update the tabs list

      // Dispose the previous controller *before* creating a new one, if it exists
      _tabController?.removeListener(
        _handleTabChange,
      ); // Remove listener from old controller
      _tabController?.dispose();

      // Create the new controller
      _tabController = TabController(length: _tabs.length, vsync: this);

      // Add listener to the new controller
      _tabController?.addListener(_handleTabChange);

      // Trigger a rebuild after the controller is initialized/updated
      // Use WidgetsBinding to ensure it happens after the current build cycle if needed,
      // but often setState is sufficient here.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // Check if the state is still mounted
          setState(() {});
        }
      });
    }
  }

  // Separate listener function for clarity
  void _handleTabChange() {
    if (_tabController != null && !_tabController!.indexIsChanging && mounted) {
      print("Tab changed to: ${_tabController!.index}");
      // Add any state changes needed when tab index changes
      // For example: setState(() { /* update based on index */ });
    }
  }

  @override
  void dispose() {
    // Remove listener and dispose the controller if it exists
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get localizations once for the build method
    final localizations = AppLocalizations.of(context)!;

    // Check if TabController is initialized. If not, show a loading indicator.
    if (_tabController == null) {
      print("build: TabController is null, showing loading indicator.");
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // If controller is initialized, build the main UI
    print("build: TabController is ready, building UI.");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 12.0,
              ),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  localizations.messages,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                actions: [
                  appbarActions(
                    icon: const FaIcon(FontAwesomeIcons.search, size: 24),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 12),
                  appbarActions(
                    icon: const FaIcon(FontAwesomeIcons.filter, size: 24),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // --- Add the CustomTabBar here ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: CustomTabBar(
              // Use the non-null controller (!) because we checked for null above
              controller: _tabController!,
              tabs: _tabs,
              onTabSelected: (index) {
                print('Selected tab index via onTap: $index');
                // Optional: Handle tab tap directly if needed.
                // The controller already handles the index change for TabBarView.
              },
            ),
          ),

          // --- End CustomTabBar ---
          Expanded(
            child: TabBarView(
              // Use the non-null controller (!)
              controller: _tabController!,
              // Ensure the number of children matches the TabController length
              children: List.generate(_tabs.length, (index) {
                // Generate content based on index or tab title
                if (index == 0) {
                  return _buildMessageList(); // Content for first tab (Chats)
                } else if (index == 1) {
                  // Example: Different content for the second tab (Calls)
                  return Center(child: Text("Content for ${_tabs[index]}"));
                }
                // Default fallback or add more conditions
                return Center(child: Text("Content for ${_tabs[index]}"));
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Your existing methods
  Widget _buildMessageList() {
    // Example: Displaying Chats
    print("Building message list for Chats tab");
    return ListView.builder(
      key: const PageStorageKey<String>(
        'chatsList',
      ), // Add key for scroll position preservation
      padding: const EdgeInsets.only(top: 8.0),
      itemCount: 6, // Example count
      itemBuilder: (context, index) => messageCard(index: index),
    );
  }

  Padding messageCard({required int index}) {
    // Added index for variety
    // Example data - replace with your actual message data
    final names = ['Elias', 'Maria', 'Peter', 'Sophia', 'David', 'Chloe'];
    final messages = [
      'Lorem ipsum dolor sit amet...',
      'Okay, see you then!',
      'Can you send me the file?',
      'Thanks for the update.',
      'Meeting rescheduled to 3 PM.',
      'Let\'s catch up tomorrow.',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(
              // Use index for slightly varied placeholders
              'https://placehold.co/80x80/dddddd/31343C?text=${names[index % names.length][0]}&font=Roboto',
            ),
            onBackgroundImageError: (_, __) {}, // Basic error handling
            backgroundColor: Colors.grey, // Fallback color
          ),
          const SizedBox(width: 16),
          // Use Expanded to prevent overflow if text is long
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  names[index % names.length], // Use example name
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4), // Add spacing
                Text(
                  messages[index % messages.length], // Use example message
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 1, // Ensure message is single line
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Placeholder for appbarActions ---
  // Replace this with your actual implementation
  Widget appbarActions({
    required FaIcon icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.all(4), // Add margin for spacing
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200], // Lighter grey
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        iconSize: 20, // Slightly smaller icon
        splashRadius: 20, // Control splash radius
        constraints: const BoxConstraints(), // Remove extra padding
        padding: const EdgeInsets.all(8), // Adjust padding
      ),
    );
  }

  // --- End Placeholder ---
}
