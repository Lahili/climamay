import 'package:climamay/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:climamay/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '3c2251dac6fc999fc0d3abef2ae4de55';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var decodedData = {};

  getLocationData() async {
    Location location = Location();
    var position = await location.getCurrentLocation();
    // var latitude = position.latitude;
    // var longitude = position.longitude;
    var latitude = 37.5665;
    var longitude = 126.9780;// for seoul

    var response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?'
            'lat=$latitude&lon=$longitude&units=metric&appid=$apiKey'));
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
      print(decodedData);
    } else {
      throw Exception('실패함ㅅㄱ');
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(decodedData: decodedData);
        },
      ),
    );
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
