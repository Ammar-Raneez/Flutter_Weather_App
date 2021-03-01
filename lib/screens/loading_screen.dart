import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = new Location();
    await location.getCurrentLocation();
    this.latitude = location.latitude;
    this.longitude = location.longitude;

    NetworkHelper networkHelper = new NetworkHelper("http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=afcb27658f65af5d2be858c6f8f81d3f");
    var decodeData = await networkHelper.getData();

    double temperature = decodeData['main']['temp'];
    int condition = decodeData['weather'][0]['id'];
    String cityName = decodeData['name'];

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
