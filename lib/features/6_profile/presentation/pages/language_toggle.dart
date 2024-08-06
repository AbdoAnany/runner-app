import 'package:flutter/material.dart';

import '../../../../core/style/color.dart';

class LanguageToggle extends StatefulWidget {
  @override
  _LanguageToggleState createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isArabic = true;
            });
          },
          child: Text(
            'AR',
            style: TextStyle(
              color: isArabic ? Colors.white : Colors.grey,
              fontWeight:isArabic ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Switch(
          activeColor: AppColors.primary,
          value: isArabic,

          onChanged: (value) {
            setState(() {
              isArabic = value;
            });
          },
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isArabic = false;
            });
          },
          child: Text(
            'EN',
            style: TextStyle(
              fontWeight:isArabic ? FontWeight.normal : FontWeight.bold,
              color: isArabic ? Colors.grey : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}