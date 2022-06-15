import 'package:climamay/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:climamay/utilities/constants.dart';
import 'package:climamay/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, this.decodedData}) : super(key: key);
  final decodedData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var temp;
  var condition;
  var cityName;

  var weatherModel = WeatherModel();
  var weatherIcon;
  var weatherMessage;

  dataConvert() {
    temp = widget.decodedData['main']['temp'];
    condition = widget.decodedData['weather'][0]['id'];
    cityName = widget.decodedData['name'];

    weatherIcon = weatherModel.getWeatherIcon(condition);
    weatherMessage = weatherModel.getMessage(temp);
  }

  @override
  void initState() {
    super.initState();
    dataConvert();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/blueprint.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }),
                      );
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      temp.round().toString(),
                      // widget.temperature.round().toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
