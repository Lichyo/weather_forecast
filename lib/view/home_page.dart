import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_forecast/model/weather_brain.dart';
import 'package:weather_forecast/model/weather.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forecast/components/pop_container.dart';
import 'package:weather_forecast/components/temp_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String _locationName = '';
  late AnimationController _animationController;
  bool _isLoad = true;
  int _selectedIndex = 0;
  final WeatherBrain _weatherBrain = WeatherBrain();
  List<Weather> weathers = [];

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
    weathers.add(
      Weather(
          locationName: 'locationName',
          wx: 'wx',
          pop: 0,
          minT: 0,
          maxT: 0,
          ci: ''),
    );
  }

  Future<void> initWeathers({required String locationName}) async {
    weathers = await _weatherBrain.initWeatherData(locationName: locationName);
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
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      await initWeathers(locationName: _locationName);
                      setState(() {
                        _isLoad = false;
                      });
                    },
                    child: const Text('確認'),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !_isLoad,
            child: Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        TempContainer(
                          weatherBrain: _weatherBrain,
                          title: 'Min Temp',
                          temp: 10,
                        ),
                        const VerticalDivider(
                          thickness: 1,
                        ),
                        TempContainer(
                          weatherBrain: _weatherBrain,
                          title: 'Max Temp',
                          temp: 30,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 30.0,
                    ),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        PopContainer(
                          pop: 70,
                        ),
                        const VerticalDivider(
                          thickness: 1,
                        ),
                        // ci
                        Expanded(
                          child: Container(
                            color: Colors.redAccent.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
