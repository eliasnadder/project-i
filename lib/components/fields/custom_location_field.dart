import 'package:flutter/material.dart';
import 'package:example1/constants/themes/custom_theme.dart';
import 'package:geolocator/geolocator.dart';

import '../indicators/custom_indicator.dart';

class LocationTextField extends StatefulWidget {
  final TextEditingController locationController;
  final Function(String)? onChanged;

  const LocationTextField({
    super.key,
    required this.locationController,
    this.onChanged,
  });

  @override
  _LocationTextFieldState createState() => _LocationTextFieldState();
}

class _LocationTextFieldState extends State<LocationTextField> {
  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please turn the location on')),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permission to access the location was denied'),
            ),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Permission to access the location has been permanently denied. Please activate it from application settings',
            ),
          ),
        );
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CustomIndicator(color: AppColors.primary, size: 100),
          );
        },
      );

      Position position = await Geolocator.getCurrentPosition();

      Navigator.pop(context);

      setState(() {
        widget.locationController.text =
            '${position.latitude}, ${position.longitude}';
      });
    } catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error happened')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.locationController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).textTheme.labelSmall!.color,
        hintText: 'Press to set your location',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.location_on, color: AppColors.primary),
          onPressed: _getCurrentLocation,
        ),
      ),
      readOnly: true,
      onChanged: widget.onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please set your location';
        }
        return null;
      },
    );
  }
}
