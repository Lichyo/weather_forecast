import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_forecast/service/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String locationName = '';
  late AnimationController _animationController;
  final HTTPService _httpService = HTTPService();
  bool isLoad = false;
  int _selectedIndex = 0;

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
    _httpService.getHTTP(locationName: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('images/sun_raise.png'),
            label: '00 ~ 06',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
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
                      locationName = value;
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
                      //TODO: 確認送出查詢資料
                    },
                    child: const Text('確認'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Lottie.network(
              'https://lottie.host/a412eaae-6d84-4b34-a956-d224e1d446a9/wNaEB4gAUS.json',
              controller: _animationController,
            ),
          ),
        ],
      ),
    );
  }
}
