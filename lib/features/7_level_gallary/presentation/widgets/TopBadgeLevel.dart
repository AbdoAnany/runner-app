import 'package:flutter/material.dart';
import 'package:runner_app/core/style/color.dart';

import '../../../../core/const/const.dart';

class TopBadgeLevel extends StatelessWidget {
  final int index;
  const TopBadgeLevel({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImage.topRank(index)))),
    );
  }
}

class TopBadgeLevelGen extends StatelessWidget {
  final int index;
  const TopBadgeLevelGen({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double size = constraints.maxWidth < constraints.maxHeight
              ? constraints.maxWidth
              : constraints.maxHeight;
          size = size * 0.7;
          return Stack(
            children: [
              Align(
                  alignment: Alignment(-1, .75),
                  child: Image.asset(
                    AppImage.ribbonsNumGen(num: (index % 4) + 1),
                    width: size,
                  )),
              Container(
                clipBehavior: Clip.hardEdge,
                width: size,
                height: size,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImage.topRankGen(index)),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size * 0.25,
                    ),
                    Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          index.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: index >= 1 && index <= 100
                                ? size * 0.7
                                : size * 0.6,
                            fontFamily: "Baloo2",
                            height: .8,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Top",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size * 0.12,
                        fontFamily: "Baloo2",
                        height: .9,
                      ),
                    ),
                    SizedBox(height: size * 0.21),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

