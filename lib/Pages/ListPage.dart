import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/Pages/DetailsPage.dart';
import 'package:mobileapp/Pages/LoginPage.dart';

/// Main method of the application
class ListPage extends StatefulWidget {
  const ListPage({Key? key, required this.userObj}) : super(key: key);
  final UserCredential userObj;
  @override
  _ListPageState createState() => _ListPageState( );
}

/// This class is responsible for the ListPage state
class _ListPageState extends State<ListPage> {
  late List< dynamic>  _hotelsList = [];

  /// This method is responsible for fetching the data from the API
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// This method is responsible for fetching the data from the API
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json'));
      if (response.statusCode == 200) {
        // Request was successful
        final data = response.body;
        // Decode the JSON
        JsonDecoder decoder = const JsonDecoder();
        final jsonData = decoder.convert(data);
        _hotelsList = jsonData['data'];
        print(_hotelsList);
      } else {
        // Request failed
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Error occurred
      print('Error: $error');
    }
  }
  /// This method is responsible for signing out the user
  Future<void> _handleSignOut() async {
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();
      // Sign out from Google
      await GoogleSignIn().signOut();
      // Navigate to login page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  LoginPage(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(37,160,162, 1),
          title: const Center(child: Text('Login View')),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.userObj.user!.photoURL.toString()),
                          radius: 20,
                        ),

                        const SizedBox(height: 20,),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(widget.userObj.user!.displayName.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(widget.userObj.user!.email.toString()),
                              const SizedBox(height: 10,),
                              ElevatedButton(
                                onPressed: _handleSignOut,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(0,145,147, 1),
                                  side: const BorderSide(color: Colors.white, width: 1),
                                ),
                                child: const Text('Sign Out'),
                              ),
                            ],
                          ),
                        )
                      ]),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.separated(
                            shrinkWrap: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            physics: const BouncingScrollPhysics(),

                            separatorBuilder: (context, index) => const Divider(
                              color: Colors.black,
                            ),
                            itemCount: _hotelsList.length,

                            itemBuilder: (context, index) {
                              print(_hotelsList[index].toString());
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DetailsView(
                                      title: _hotelsList[index]['title'].toString(),
                                      address: _hotelsList[index]['address'].toString(),
                                      imageUrl: _hotelsList[index]['image']['large'].toString(),
                                      description: _hotelsList[index]['description'].toString(),
                                      latitude: double.parse( _hotelsList[index]['latitude']),
                                      longitude: double.parse(_hotelsList[index]['longitude']),
                                    )
                                    ),
                                  );
                                },
                                child: ListTile(
                                    leading: CircleAvatar(
                                        backgroundImage: NetworkImage(_hotelsList[index]['image']['large'].toString()),
                                        backgroundColor: const Color.fromRGBO(37,160,162, 1),
                                        radius: 25,
                                        child: Text(_hotelsList[index]['title'].toString().substring(0,1),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        )
                                    ),
                                    title: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(_hotelsList[index]['title'].toString()),
                                        Container(
                                          margin: const EdgeInsets.only(top: 10),
                                          child: Text(_hotelsList[index]['address'].toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              );
                            },
                          )
                      )
                    ],
                  )
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
