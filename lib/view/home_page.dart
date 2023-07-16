import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_forecast/model/weather_brain.dart';
import 'package:weather_forecast/model/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String _locationName = '';
  late AnimationController _animationController;
  final bool _isLoad = false;
  bool _hasWeatherData = false;
  int _selectedIndex = 0;
  final WeatherBrain _weatherBrain = WeatherBrain();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  Future<void> initWeathers({required String locationName}) async {
    List<Weather> weathers =
        await _weatherBrain.initWeatherData(locationName: locationName);
    for (int i = 0; i < 3; i++) {
      print('locationName : ${weathers[i].locationName}');
      print('wx : ${weathers[i].wx}');
      print('minT : ${weathers[i].minT}');
      print('maxT : ${weathers[i].maxT}');
      print('pop : ${weathers[i].pop}');
      print('ci : ${weathers[i].ci}');
      print('===========================');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                    onChanged: (value) {
                      _locationName = value;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: '請輸入城市名稱',
                      // errorText: '尚未輸入城市名稱',
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      initWeathers(locationName: _locationName);
                    },
                    child: const Text('確認'),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !_hasWeatherData,
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