// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, file_names, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:apis_practice/BigDataApiPractice/BigDataApiModel.dart';
import 'package:apis_practice/BigDataApiPractice/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BigDataApi extends StatefulWidget {
  const BigDataApi({Key? key}) : super(key: key);

  @override
  _BigDataApiState createState() => _BigDataApiState();
}

class _BigDataApiState extends State<BigDataApi> {
  late Future<WeatherAppModel> Data;
  String city = 'saddiqabad';
  late String text;
  late IconData icon;
  late IconData weatherIcon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Data = Network().fetchData(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder<WeatherAppModel>(
      future: Data,
      builder: (context, AsyncSnapshot<WeatherAppModel> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return SafeArea(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 17),
                  decoration: InputDecoration(
                      helperText: 'e.g: karachi',
                      filled: true,
                      fillColor: Colors.pinkAccent,
                      hintText: 'Search your City Name',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.none,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      focusColor: Colors.pink),
                  onSubmitted: (value) {
                    setState(() {
                      city = value;
                      Data = Network().fetchData(city);
                    });
                  },
                ),
              ),
              Center(
                child: Text(
                  '${data!.city.name} - ${data.city.country}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                    '${Utils.getFormattedDate(DateTime.fromMillisecondsSinceEpoch(data.list[0].dt * 1000))}'),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Icon(
                Utils.getWeatherIcon('${data.list[0].weather[0].main}'),
                size: 170,
                color: Colors.pinkAccent,
              )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${data.list[0].temp.day.toStringAsFixed(0)}°C ',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                  Text('${data.list[0].weather[0].description}',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w300)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RowItem(
                          text: '${data.list[0].speed.toStringAsFixed(1)} mi/h',
                          icon: Icons.air),
                      RowItem(
                          text: '${data.list[0].humidity.toStringAsFixed(1)} %',
                          icon: Icons.emoji_emotions_outlined),
                      RowItem(
                          text:
                              '${data.list[0].temp.max.toStringAsFixed(0)}°C ',
                          icon: Icons.thermostat_outlined),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.59,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13)),
                    color: Colors.pinkAccent,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 1);
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: data.list.length - 1,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: Column(children: [
                              Text(
                                  '${Utils.getFormattedDay(DateTime.fromMillisecondsSinceEpoch(data.list[index + 1].dt * 1000))}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Utils.getWeatherIcon(
                                          '${data.list[index + 1].weather[0].main}'),
                                      color: Colors.pinkAccent,
                                      size: 30,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 9.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    'Max:  ${data.list[index + 1].temp.max.toStringAsFixed(0)}°C ',
                                                    style: txt()),
                                                Icon(
                                                  Icons
                                                      .arrow_circle_up_outlined,
                                                  size: 15,
                                                  color: Colors.redAccent,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Min:  ${data.list[index + 1].temp.min.toStringAsFixed(0)}°C ',
                                                  style: txt(),
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_circle_down_outlined,
                                                  color: Colors.green,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                            Text(
                                                'Hum:  ${data.list[index + 1].humidity.toStringAsFixed(1)} %',
                                                style: txt()),
                                            Text(
                                                'Wind: ${data.list[index + 1].speed.toStringAsFixed(1)} mi/h',
                                                style: txt())
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]));
                      }),
                ),
              )
            ]),
          );
        } else
          return CircularProgressIndicator();
      },
    )));
  }

  TextStyle txt() {
    return TextStyle(fontWeight: FontWeight.w400);
  }
}

class RowItem extends StatelessWidget {
  const RowItem({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: TextStyle(fontWeight: FontWeight.w400)),
        SizedBox(
          height: 5,
        ),
        Icon(icon, color: Colors.pinkAccent)
      ],
    );
  }
}

class Network {
  Future<WeatherAppModel> fetchData(city) async {
    String url = 'https://api.openweathermap.org/data/2.5/forecast/daily?q=' +
        city +
        Utils.appid +
        '&units=metric';

    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return WeatherAppModel.fromJson(json.decode(response.body));
    } else
      throw Exception('Failed to fetch data');
  }
}
