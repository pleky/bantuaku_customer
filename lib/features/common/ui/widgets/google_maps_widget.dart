// reusable google maps widget
import 'package:bantuaku_customer/constants/languages.dart';
import 'package:bantuaku_customer/theme/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapsWidget extends StatefulWidget {
  final Function(LatLng, String) onLocationSelected;
  final Function(LatLng, String)? onChangePinLocation;

  const GoogleMapsWidget({Key? key, required this.onLocationSelected, this.onChangePinLocation}) : super(key: key);

  @override
  _GoogleMapsWidgetState createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndFetchLocation();
  }

  Future<void> _checkPermissionsAndFetchLocation() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
    } else {
      setState(() {
        _error = 'Location permission denied';
        _isLoading = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onTap(LatLng location, [String address = '']) {
    setState(() {
      _selectedLocation = location;
    });
    widget.onLocationSelected(location, address);
  }

  Future<String> getAddressFromLatLng(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
      }
      return "";
    } catch (e) {
      return "Unknown Address";
    }
  }

  Future<String?> getAddressFromGoogle(double lat, double lng) async {
    final apiKey = "AIzaSyAafCTfJ-10tBkzVEQYNKyxaUbvu2o9s5M"; // pastikan billing aktif di GCP
    final dio = Dio();

    try {
      final response = await dio.get(
        "https://maps.googleapis.com/maps/api/geocode/json",
        queryParameters: {
          "latlng": "$lat,$lng",
          "key": apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data["status"] == "OK" && data["results"].isNotEmpty) {
          return data["results"][0]["formatted_address"];
        } else {
          print("Google Geocode error: ${data["status"]}");
          return null;
        }
      } else {
        print("HTTP error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Dio error: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text(_error!));
    }

    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _selectedLocation!,
            zoom: 15,
          ),
          onTap: (location) async {
            String address = await getAddressFromGoogle(location.latitude, location.longitude) ?? "Unknown Address";
            print("Address from reverse geocoding: $address");
            _onTap(location, address);
          },
          markers: _selectedLocation != null
              ? {
                  Marker(
                    markerId: const MarkerId('selected-location'),
                    position: _selectedLocation!,
                  ),
                }
              : {},
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          liteModeEnabled: false,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () async {
              Position position = await Geolocator.getCurrentPosition(
                  locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.high,
              ));
              LatLng currentLocation = LatLng(position.latitude, position.longitude);
              _mapController?.animateCamera(CameraUpdate.newLatLng(currentLocation));
              String address =
                  await getAddressFromGoogle(currentLocation.latitude, currentLocation.longitude) ?? "Unknown Address";
              print("Address from reverse geocoding: $address");
              _onTap(currentLocation, address);
            },
            color: AppColors.primaryDark,
            iconSize: 30,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.whiteBg),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: AppColors.mono20),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 16,
          right: 16,
          child: AddressAutocompleteTextField(
            componentCountry: 'ID',
            clearButton: Icon(MingCuteIcons.mgc_close_circle_fill, color: AppColors.mono60),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.whiteBg,
              hintText: Languages.searchLocation,
              isDense: true,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.mono60),
              ),
            ),
            suggestionsOverlayDecoration: BoxDecoration(
              color: AppColors.whiteBg,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            mapsApiKey: "AIzaSyAafCTfJ-10tBkzVEQYNKyxaUbvu2o9s5M",
            debounceTime: 300,
            onSuggestionClick: (place) {
              final latLng = LatLng(place.lat!, place.lng!);
              _mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
              _onTap(latLng, place.formattedAddress!);
            },
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
