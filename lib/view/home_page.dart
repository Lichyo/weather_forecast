import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_forecast/service/weather_api_service.dart';
import 'package:weather_forecast/model/weather.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weather_forecast/view/forecast_page.dart';
import 'package:weather_forecast/constants.dart';
import 'package:weather_forecast/components/custom_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isInit = true;
  bool _isLoad = false;
  int _selectedIndex = 0;
  final _weatherApiService = WeatherApiService.instance;
  final _fieldText = TextEditingController();
  final FocusNode _focus = FocusNode();
  String _locationName = '';
  List<Weather> _weathers = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFocusChange() {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(queryLocation: (locationName) {
        _locationName = locationName;
        _fieldText.text = _locationName;
      }),
    );
    _focus.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _weathers.add(_weatherApiService.defaultWeather());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: !_isInit,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage('images/sun_raise.png'),
              ),
              label: '00 ~ 06',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage('images/sun_set.png'),
              ),
              label: '06 ~ 18',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage('images/moon_light.png'),
              ),
              label: '18 ~ 06',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                    focusNode: _focus,
                    controller: _fieldText,
                    onChanged: (value) {
                      _locationName = value;
                    },
                    decoration: kSearchBarInputDecoration,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      setState(() {
                        _isLoad = true;
                      });
                      try {
                        _weathers = await _weatherApiService.getWeatherData(
                          locationName: _locationName,
                        );
                      } catch (e) {
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "查無資料",
                          desc: "請確認網路連線，或是城市名稱無錯誤",
                          buttons: [
                            DialogButton(
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                              child: const Text(
                                "回主畫面",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ],
                        ).show();
                      }

                      setState(() {
                        _isLoad = false;
                        _isInit = false;
                      });
                      _fieldText.clear();
                      _locationName = '';
                    },
                    child: const Text('確認'),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !_isInit,
            child: _isLoad
                ? const Center(child: CircularProgressIndicator())
                : ForecastPage(
                    weather: _weathers[_selectedIndex],
                  ),
          ),
          Visibility(
            visible: _isInit,
            child: Expanded(
              child: Lottie.network(
                'https://lottie.host/a412eaae-6d84-4b34-a956-d224e1d446a9/wNaEB4gAUS.json',
                controller: _animationController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
