import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'MapPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// This is the stateless widget that the main application instantiates.
class DetailsView extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String address;
  final String description;
  final double latitude;
  final double longitude;

  /// This is the constructor for the DetailsView class
  DetailsView({
    required this.imageUrl,
    required this.title,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0,147,145, 1),
        title: const Center(child: Text('Details')),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapView(
                    title: this.title,
                    address: this.address,
                    latitude: this.latitude,
                    longitude: this.longitude,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color.fromRGBO(213, 229, 229, 1.0),
            child: Center(
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width - 200,
                height: MediaQuery.of(context).size.height / 3,
                imageUrl: imageUrl,
                placeholder: (context, url) => const SpinKitWaveSpinner(
                  color: Color.fromRGBO(0,147,145,1),
                  size: 150.0,
                ) ,

                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: $title',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Description: $description',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}