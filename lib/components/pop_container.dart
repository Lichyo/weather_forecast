import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopContainer extends StatelessWidget {
  const PopContainer({
    super.key,
    required this.pop,
    required this.image,
  });
  final Image image;
  final int pop;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Pop',
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
                    child: Text(
                      '$pop %',
                      style: GoogleFonts.getFont(
                        'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: image,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
