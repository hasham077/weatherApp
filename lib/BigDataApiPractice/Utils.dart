// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Utils {
  static var appid = '&appid=ed60fcfbd110ee65c7150605ea8aceea';
  static String getFormattedDate(DateTime dateTime) {
    return new DateFormat("EEE, MMM d, y").format(dateTime);
  }

   static String getFormattedDay(DateTime dateTime) {
    return new DateFormat("EEEE").format(dateTime);
  }

  static IconData getWeatherIcon(String weather) {
    switch (weather) {
      case ('Clouds'):
        return (FontAwesomeIcons.cloud);
        break;

      case ('Rain'):
        return (FontAwesomeIcons.cloudRain);
        break;

      default:
        return (FontAwesomeIcons.solidSun);
        break;
    }
  }
}
