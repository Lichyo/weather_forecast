import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CiContainer extends StatelessWidget {
  const CiContainer({
    super.key,
    required this.ci,
  });

  final String ci;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: Text(
                'Ci',
                style: GoogleFonts.getFont(
                  'Ubuntu',
                  color: Colors.grey.shade600,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 15.0),
                  child: Text(
                    ci,
                    style: const TextStyle(
                      fontFamily: 'cute',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
