import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shallwe_app/config/color_palette.dart';
import 'package:shallwe_app/custom_widget/expandable_fab.dart';
import 'package:shallwe_app/data/firebase_data_control.dart';
import 'package:shallwe_app/data/get_location.dart';
import 'package:shallwe_app/data/get_weather_svg.dart';
import 'package:shallwe_app/data/network.dart';
import 'package:shallwe_app/model/news.dart';
import 'package:shallwe_app/model/weather.dart';
import 'package:shallwe_app/size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  dynamic loggedUser;
  late NewsList news;
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.8);
  int currentPage = 0;
  late Timer _timer;
  late TooltipBehavior _tooltipBehavior;
  late Future _getTempe;
  late Future _getNews;

  void launchURL(url) async {
    await launch(url, forceWebView: true, forceSafariVC: true);
  }

  Future<List> getCurrentWeather() async {
    final APIKEY = dotenv.env['WEATHER_KEY'];
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    print(
        'Latitude: ${myLocation.myLatitude}    Longitude: ${myLocation.myLongitude}');
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=${myLocation.myLatitude}&lon=${myLocation.myLongitude}&appid=$APIKEY&units=metric');
    var weatherData = await network.getJsonData();

    return await updateData(weatherData);
  }

  List updateData(dynamic weatherData) {
    int temp = 0;
    String cityName = '';
    Widget w_icon;
    double temp2 = weatherData['main']['temp'];
    int condition = weatherData['weather'][0]['id'];
    temp = temp2.round(); //round는 반올림, int반환 //toInt()를 써도 결과는 같음
    cityName = weatherData['name'];
    w_icon = getWeatherIcon(condition);
    return [cityName, temp, w_icon];
  }

  @override
  void initState() {
    _getTempe = getTempeData();
    _getNews = getNewsData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    getCurrentWeather();

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentPage < 10) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      _controller.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('티끌', style: TextStyle(fontFamily: 'IM_Hyemin'))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50 * getScaleHeight(context),
            ),
            Row(
              children: [
                Container(
                  height: 160 * getScaleHeight(context),
                  width: 53 * getScaleWidth(context),
                ),
                Container(
                  height: 160 * getScaleHeight(context),
                  width: 400 * getScaleWidth(context),
                  child: Text("과거-현재-미래\n기온 예측 및 비교",
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                          fontFamily: "IM_Hyemin",
                          fontStyle: FontStyle.normal,
                          fontSize: 27),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
            SizedBox(
              height: 21 * getScaleHeight(context),
            ),
            Container(
              width: 670 * getScaleWidth(context),
              height: 500 * getScaleHeight(context),
              decoration: BoxDecoration(
                color: const Color(0xfff1f1f5),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: _drawChart(),
            ),
            SizedBox(
              height: 40 * getScaleHeight(context),
            ),
            _buildNews(context),
            SizedBox(
              height: 62 * getScaleHeight(context),
            ),
            _buildCurrentWeather(context),
          ],
        ),
      ),
      floatingActionButton: expandableFab(context, widget.key),
    );
  }

  Container _buildNews(BuildContext context) {
    return Container(
      // 수평적으로 대칭(symmetric)의 마진을 추가 -> 화면 위, 아래에 20픽세의 마진 삽입
      margin: EdgeInsets.symmetric(vertical: 20.0),
      // 컨테이너의 높이를 200으로 설정
      height: 168 * getScaleWidth(context),
      // 리스트뷰 추가
      child: FutureBuilder(
        future: _getNews,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
          if (snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator());
          }
          //error가 발생하게 될 경우 반환하게 되는 부분
          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15, fontFamily: 'IM_Hyemin'),
              ),
            );
          }
          // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
          else {
            news = snapshot.data;
            return PageView.builder(
              // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
              scrollDirection: Axis.horizontal,
              itemCount: news.newsList.length,
              controller: _controller,

              itemBuilder: (BuildContext context, int index) {
                return newsContainer(index);
              },
            );
          }
        },
      ),
    );
  }

  Row _buildCurrentWeather(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 75 * getScaleWidth(context),
        ),
        FutureBuilder(
          future: getCurrentWeather(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: 250 * getScaleHeight(context),
                width: 300 * getScaleWidth(context),
                padding: EdgeInsets.only(right: 20 * getScaleWidth(context)),
                color: Palette.TextFieldColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    snapshot.data[2],
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          snapshot.data[0],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                              fontSize: 48.0 * getScaleHeight(context)),
                        ),
                        Text(
                          snapshot.data[1].toString() + '°C',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                              fontSize: 48.0 * getScaleHeight(context)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  Widget _drawChart() {
    return FutureBuilder(
      future: _getTempe,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          WeatherData temper = snapshot.data;
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            legend: Legend(isVisible: true, position: LegendPosition.bottom),
            tooltipBehavior: _tooltipBehavior,
            series: <LineSeries<WeatherDay, String>>[
              LineSeries(
                name: temper.weatherData[0].year,
                dataSource: temper.weatherData[0].yearData,
                xValueMapper: (WeatherDay weather, _) => weather.day,
                yValueMapper: (WeatherDay weather, _) => weather.temper,
                markerSettings: MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.circle,
                ),
                color: Colors.blue[300],
                // dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
              LineSeries(
                name: temper.weatherData[1].year,
                dataSource: temper.weatherData[1].yearData,
                xValueMapper: (WeatherDay weather, _) => weather.day,
                yValueMapper: (WeatherDay weather, _) => weather.temper,
                markerSettings: MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.circle,
                ),
                color: Colors.red[300],
                // dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
              LineSeries(
                name: temper.weatherData[2].year,
                dataSource: temper.weatherData[2].yearData,
                xValueMapper: (WeatherDay weather, _) => weather.day,
                yValueMapper: (WeatherDay weather, _) => weather.temper,
                markerSettings: MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.circle,
                ),
                color: Colors.purple[300],
                // dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget newsContainer(int index) {
    return Container(
      height: 168 * getScaleHeight(context),
      child: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xfff1f1f5),
              fixedSize: Size(
                570 * getScaleWidth(context),
                168 * getScaleHeight(context),
              ),
              elevation: 0.3,
            ),
            onPressed: () {
              launchURL(news.newsList[index].url);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    news.newsList[index].pubCompany,
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 13.0),
                  ),
                ),
                Text(
                  news.newsList[index].title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 17.0),
                ),
                Container(
                  height: 28.5 * getScaleHeight(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 17,
                          ),
                          Text(
                            news.newsList[index].reporter,
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      news.newsList[index].date,
                      style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
