import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_forecast/model/weather_brain.dart';
import 'package:weather_forecast/model/weather.dart';
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
  bool _isLoad = true;
  int _selectedIndex = 0;
  final WeatherBrain _weatherBrain = WeatherBrain();
  final _fieldText = TextEditingController();
  final FocusNode _focus = FocusNode();
  String _locationName = '';
  List<Weather> weathers = [];

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
    weathers.add(_weatherBrain.defaultWeather());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: !_isLoad,
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
            padding: const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
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
                      weathers = await _weatherBrain.getWeatherData(
                        locationName: _locationName,
                      );
                      setState(() {
                        _isLoad = false;
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
            visible: !_isLoad,
            child: ForecastPage(
              weather: weathers[_selectedIndex],
            ),
          ),
          Visibility(
            visible: _isLoad,
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
