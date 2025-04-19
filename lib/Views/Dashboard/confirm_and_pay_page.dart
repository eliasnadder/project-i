import 'package:flutter/material.dart';
import 'package:example1/constants/themes/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Placeholder for actual data models you might have
class BookingDetails {
  final String imageUrl;
  final String title;
  final String description;
  final double rating;
  final int reviewCount;
  final bool isSuperhost;

  BookingDetails({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.isSuperhost,
  });
}

class ConfirmAndPayScreen extends StatefulWidget {
  // You would pass necessary data here, e.g., booking details, prices
  const ConfirmAndPayScreen({super.key});

  @override
  State<ConfirmAndPayScreen> createState() => _ConfirmAndPayScreenState();
}

class _ConfirmAndPayScreenState extends State<ConfirmAndPayScreen> {
  // Placeholder for state, e.g., selected payment option
  int _selectedPaymentOption = 0; // 0 for pay now, 1 for pay later

  // Placeholder data - replace with actual data passed to the widget
  final booking = BookingDetails(
    imageUrl:
        'https://via.placeholder.com/150', // Replace with actual image URL
    title: 'Soul Escape',
    description: 'Entire cabin',
    rating: 4.92,
    reviewCount: 90,
    isSuperhost: true,
  );

  final String tripDates = '28 May - 1 Jun';
  final String guests = '1 guest';
  final double pricePerNight = 115.00;
  final int nights = 5;
  final double serviceFee = 96.60;
  final String currencySymbol = '£'; // Or use NumberFormat for localization

  AppLocalizations lang(BuildContext context) => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    final double subtotal = pricePerNight * nights;
    final double total = subtotal + serviceFee;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          lang(context).confirm_and_pay,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0, // Subtle shadow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBookingDetails(booking),
              const SizedBox(height: 16),
              _buildCancellationInfo(),
              const Divider(height: 32),
              _buildYourTripSection(tripDates, guests),
              const Divider(height: 32),
              _buildChoosePaymentSection(total),
              const Divider(height: 32),
              _buildPriceDetails(
                pricePerNight,
                nights,
                serviceFee,
                total,
                currencySymbol,
              ),
              const Divider(height: 32),
              _buildPayWithSection(),
              const Divider(height: 32),
              _buildRequiredForTripSection(),
              const Divider(height: 32),
              _buildCancellationPolicySection(),
              const Divider(height: 32),
              _buildGroundRulesSection(),
              const Divider(height: 32),
              _buildAgreementText(),
              const SizedBox(height: 90), // Space for the bottom button
            ],
          ),
        ),
      ),
      bottomSheet: _buildConfirmButton(
        total,
        currencySymbol,
      ), // Or use bottomNavigationBar
    );
  }

  // --- Helper Widgets for Sections ---

  Widget _buildBookingDetails(BookingDetails details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            details.imageUrl,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            // Add error builder for network images
            errorBuilder:
                (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 60),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                details.description,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                details.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.red, size: 16),
                  const SizedBox(width: 4),
                  Text('${details.rating} (${details.reviewCount} reviews)'),
                  if (details.isSuperhost) ...[
                    const Text(' · '),
                    const Icon(
                      Icons.shield,
                      color: Colors.red,
                      size: 16,
                    ), // Placeholder for Superhost icon
                    const Text(' Superhost'),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCancellationInfo() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Free cancellation before 28 May. Get a full refund if you change your mind.',
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.calendar_today_outlined),
      ],
    );
  }

  Widget _buildYourTripSection(String dates, String guests) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your trip',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Dates'),
            TextButton(
              onPressed: () {
                /* Handle Edit Dates */
              },
              child: Text(dates),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
            ),
            TextButton(
              onPressed: () {
                /*TODO*/
              },
              child: const Text(
                'Edit',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Guests'),
            Text(guests),
            TextButton(
              onPressed: () {
                /*TODO*/
              },
              child: const Text(
                'Edit',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChoosePaymentSection(double total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose how to pay',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Option 1: Pay Now
        RadioListTile<int>(
          title: Text('Pay ${currencySymbol}${total.toStringAsFixed(2)} now'),
          value: 0,
          groupValue: _selectedPaymentOption,
          onChanged: (value) {
            setState(() {
              _selectedPaymentOption = value!;
            });
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity:
              ListTileControlAffinity.trailing, // Radio button on the right
          activeColor: AppColors.primary,
        ),
        // Option 2: Pay Later (Example structure)
        RadioListTile<int>(
          //TODO: Add logic for pay later option display if needed
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pay part now, part later'),
              Text(
                'Pay £XXX.XX now, and the rest (£YYY.YY) on 20 May 2025. No extra fees.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          subtitle: TextButton(
            onPressed: () {},
            child: const Text(
              'More info',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 12,
              ),
            ),
          ),
          value: 1,
          groupValue: _selectedPaymentOption,
          onChanged: (value) {
            setState(() {
              _selectedPaymentOption = value!;
            });
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.trailing,
          activeColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildPriceDetails(
    double pricePerNight,
    int nights,
    double serviceFee,
    double total,
    String currencySymbol,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildPriceRow(
          '${currencySymbol}${pricePerNight.toStringAsFixed(2)} x $nights nights',
          '${currencySymbol}${(pricePerNight * nights).toStringAsFixed(2)}',
        ),
        const SizedBox(height: 8),
        _buildPriceRow(
          'Airbnb service fee',
          '${currencySymbol}${serviceFee.toStringAsFixed(2)}',
        ),
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total (GBP)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ), // Assuming GBP based on image
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${currencySymbol}${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    /* Handle More Info */
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'More info',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label), Text(amount)],
    );
  }

  Widget _buildPayWithSection() {
    // TODO: Add actual payment icons (e.g., using flutter_svg or specific icon assets)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pay with',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Placeholder Icons - Replace with actual payment method icons/widgets
                const Icon(Icons.credit_card, size: 30), // Example
                const SizedBox(width: 8),
                const Icon(
                  Icons.credit_card,
                  size: 30,
                  color: Colors.orange,
                ), // Example
                const SizedBox(width: 8),
                const Icon(
                  Icons.paypal,
                  size: 30,
                  color: Colors.blue,
                ), // Example
              ],
            ),
            OutlinedButton(
              onPressed: () {
                /* Handle Add Payment Method */
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRequiredForTripSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Required for your trip',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone number',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Add and confirm your phone number to get trip updates.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {
                /* Handle Add Phone Number */
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCancellationPolicySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cancellation policy',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // Make sure text wraps correctly
        const Text(
          'Free cancellation before 28 May. Cancel before check-in on 28 May for a partial refund.',
        ), // Simplified text
        TextButton(
          onPressed: () {
            /* Handle Learn More */
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
          ),
          child: const Text(
            'Learn more',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Widget _buildGroundRulesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ground rules',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "We ask every guest to remember a few simple things about what makes a great guest.",
        ),
        const SizedBox(height: 8),
        _buildRuleItem("Follow the house rules"),
        _buildRuleItem("Treat your Host's home like your own"),
      ],
    );
  }

  Widget _buildRuleItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildAgreementText() {
    // Use RichText if you need clickable links within the text
    return Text(
      "By selecting the button below, I agree to the Host's House Rules, Ground rules for guests, Airbnb's Rebooking and Refund Policy, and that Airbnb can charge my payment method if I'm responsible for damage. I agree to pay the total amount shown if the Host accepts my booking request. I also agree that my booking is subject to the terms and conditions specified between you and Airbnb Payments Luxembourg S.A.", // Simplified text
      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
    );
  }

  Widget _buildConfirmButton(double total, String currencySymbol) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white, // To overlay content behind it
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(
            double.infinity,
            50,
          ), // Full width, fixed height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          // --- TODO: Implement Confirmation Logic ---
          // 1. Validate selected payment method, phone number etc.
          // 2. Process payment based on _selectedPaymentOption
          // 3. Navigate to success screen or show confirmation dialog
          print('Confirm and Pay button pressed!');
          print('Selected payment option: $_selectedPaymentOption');
          print('Total: ${currencySymbol}${total.toStringAsFixed(2)}');
        },
        child: Text(
          lang(context).confirm_reservation,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
