import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WeatherData {
  WeatherData({required this.weatherData});
  final List<WeatherYear> weatherData;

  factory WeatherData.fromDocument(DocumentSnapshot doc) {
    Map getDocs = doc.data() as Map;
    List<WeatherYear> yearList = [];

    getDocs.forEach((key, value) {
      print(key);
      print(value);
      yearList.add(WeatherYear.fromDocument(key, value));
    });

    return WeatherData(weatherData: yearList);
  }
}

class WeatherYear {
  WeatherYear({required this.year, required this.yearData});
  late String year;
  late List<WeatherDay> yearData;

  factory WeatherYear.fromDocument(String key, List value) {
    String year = key;
    List<WeatherDay> dayList = [];

    value.forEach((value) {
      dayList.add(WeatherDay.fromDocument(value));
    });

    return WeatherYear(year: year, yearData: dayList);
  }
}

class WeatherDay {
  WeatherDay({required this.day, required this.temper});
  // late MaterialColor lineColor;
  late String day;
  late double temper;

  factory WeatherDay.fromDocument(Map value) {
    return WeatherDay(
      day: value.keys.first,
      temper: double.parse(value.values.first),
    );
  }
}
