import 'package:flutter/material.dart';

import '../../../../core/const/const.dart';

class BadgeLevelGen extends StatelessWidget {
  final int index;
  const BadgeLevelGen({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;

        return Container(
          clipBehavior: Clip.hardEdge,
          width: size,
          height: size,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImage.badgeGen(index)),
              fit: BoxFit.contain,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size * 0.15,
              ),
              Image.asset(
                AppImage.starNumGen(num: (index % 3) + 1),
                width: size * 0.4,
              ),
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    index.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: size * 0.5,
                      fontFamily: "Baloo2",
                      height: 0.7,
                    ),
                  ),
                ),
              ),
              Text(
                "Day",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size * 0.12,
                  fontFamily: "Baloo2",
                ),
              ),
              SizedBox(height: size * 0.21),
            ],
          ),
        );
      },
    );
  }
}
