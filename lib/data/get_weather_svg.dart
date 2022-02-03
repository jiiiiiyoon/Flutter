import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget getWeatherIcon(int condition) {
  if (condition < 300) {
    return SvgPicture.asset(
      'svg/climacon-cloud_lightning.svg',
      color: Colors.black87,
    );
  } else if (condition < 600) {
    return SvgPicture.asset(
      'svg/climacon-cloud_snow_alt.svg',
      color: Colors.black87,
    );
  } else if (condition == 800) {
    return SvgPicture.asset(
      'svg/climacon-sun.svg',
      color: Colors.black87,
    );
  } else if (condition <= 804) {
    return SvgPicture.asset(
      'svg/climacon-cloud_sun.svg',
      color: Colors.black87,
    );
  } else {
    return SvgPicture.asset('svg/icon.svg');
  }
}
