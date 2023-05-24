import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Main application instantiates.
class MapView extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String title;
  final String address;

  MapView({required this.latitude, required this.longitude , required this.title, required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0,147,145, 1),
        title: const Center(child: Text('Map')),
      ),
      body: FlutterMap(
        options: MapOptions(
          bounds: LatLngBounds(
            LatLng(latitude, longitude),
            LatLng(latitude, longitude),
          ),
          center: LatLng(latitude, longitude),
          zoom: 15.0,
        ) ,
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width ,
                  color: const Color.fromRGBO(0,145,147, 1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.white),),
                        const SizedBox(height: 8.0),
                        Text(address, style: const TextStyle(fontSize: 16.0,color: Colors.white60),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          MarkerLayer(
            markers: [
              Marker(
                anchorPos: AnchorPos.align(AnchorAlign.top),
                width: 80.0,
                height: 80.0,
                point: LatLng(latitude, longitude),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}