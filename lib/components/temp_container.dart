import 'package:flutter/material.dart';
import 'package:weather_forecast/model/weather_brain.dart';
import 'package:google_fonts/google_fonts.dart';

class TempContainer extends StatelessWidget {
  const TempContainer({
    super.key,
    required this.temp,
    required this.title,
    required WeatherBrain weatherBrain,
  }) : _weatherBrain = weatherBrain;

  final WeatherBrain _weatherBrain;
  final String title;
  final double temp;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 臺北市
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                title,
                style: GoogleFonts.getFont(
                  'Ubuntu',
                  color: Colors.grey.shade600,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      '$temp ºC',
                      style: GoogleFonts.getFont('Roboto', fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  _weatherBrain.determineTempImage(temp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}