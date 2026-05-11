// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class PickLocationMap extends StatefulWidget {
//   final Function(double lat, double lng) onConfirm;
//   final LatLng? initialLocation;
//   final bool enableMyLocation;

//   const PickLocationMap({
//     super.key,
//     required this.onConfirm,
//     this.initialLocation,
//     this.enableMyLocation = true,
//   });

//   @override
//   State<PickLocationMap> createState() => _PickLocationMapState();
// }

// class _PickLocationMapState extends State<PickLocationMap> {
//   GoogleMapController? _mapController;
//   LatLng? _selectedLocation;
//   bool _loadingLocation = false;

//   static const LatLng _defaultLocation =
//       LatLng(24.7136, 46.6753);

//   @override
//   void initState() {
//     super.initState();
//     _selectedLocation = widget.initialLocation;
//   }


//   void _onMapTap(LatLng position) {
//     setState(() {
//       _selectedLocation = position;
//     });
//   }

 
//   Future<void> _getCurrentLocation() async {
//     setState(() => _loadingLocation = true);

//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       setState(() => _loadingLocation = false);
//       return;
//     }

//     LocationPermission permission =
//         await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     if (permission == LocationPermission.deniedForever) {
//       setState(() => _loadingLocation = false);
//       return;
//     }

//     final position = await Geolocator.getCurrentPosition();

//     final latLng = LatLng(
//       position.latitude,
//       position.longitude,
//     );

//     setState(() {
//       _selectedLocation = latLng;
//       _loadingLocation = false;
//     });

//     _mapController?.animateCamera(
//       CameraUpdate.newLatLng(latLng),
//     );
//   }

 
//   void _confirmLocation() {
//     if (_selectedLocation != null) {
//       widget.onConfirm(
//         _selectedLocation!.latitude,
//         _selectedLocation!.longitude,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
       
//         GoogleMap(
//           initialCameraPosition: CameraPosition(
//             target: widget.initialLocation ?? _defaultLocation,
//             zoom: 14,
//           ),
//           onMapCreated: (controller) {
//             _mapController = controller;
//           },
//           onTap: _onMapTap,
//           myLocationEnabled: widget.enableMyLocation,
//           myLocationButtonEnabled: false,
//           markers: _selectedLocation != null
//               ? {
//                   Marker(
//                     markerId: const MarkerId("selected"),
//                     position: _selectedLocation!,
//                   ),
//                 }
//               : {},
//         ),

     
//         if (widget.enableMyLocation)
//           Positioned(
//             right: 16,
//             bottom: 120,
//             child: FloatingActionButton(
//               heroTag: "my_location",
//               mini: true,
//               onPressed: _getCurrentLocation,
//               child: _loadingLocation
//                   ? const CircularProgressIndicator(
//                       color: Colors.white,
//                     )
//                   : const Icon(Icons.my_location),
//             ),
//           ),

//         // ✅ زر التأكيد
//         Positioned(
//           bottom: 20,
//           left: 16,
//           right: 16,
//           child: ElevatedButton(
//             onPressed: _selectedLocation != null
//                 ? _confirmLocation
//                 : null,
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 16,
//               ),
//             ),
//             child: const Text("تأكيد الموقع"),
//           ),
//         ),
//       ],
//     );
//   }
// }