
import 'package:flutter/material.dart';
import 'package:runner_app/core/style/color.dart';

import '../../../../core/const/const.dart';

class LevelSeverGen extends StatelessWidget {
  final int index;
  const LevelSeverGen({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double size = constraints.maxWidth < constraints.maxHeight
              ? constraints.maxWidth
              : constraints.maxHeight;
          size = size * 0.99;
          return Stack(
            children: [

              Container(
                clipBehavior: Clip.hardEdge,
                width: size,
                height: size,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(    AppImage.levelSelverNumGen(num:  1),),
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
                          (index).toString(),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: index >= 1 && index <= 100
                                ? size * 0.5
                                : size * 0.6,
                            fontFamily: "Baloo2",
                            height: .8,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "level",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size * 0.2,
                        fontFamily: "Baloo2",
                        height: .9,
                      ),
                    ),
                    SizedBox(height: size * 0.15),
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
class LevelGoldenGen extends StatelessWidget {
  final int index;
  const LevelGoldenGen({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double size = constraints.maxWidth < constraints.maxHeight
              ? constraints.maxWidth
              : constraints.maxHeight;
          size = size * 0.99;
          return Stack(
            children: [

              Container(
                clipBehavior: Clip.hardEdge,
                width: size,
                height: size,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(    AppImage.levelSelverNumGen(num:  1),),
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
                          (index).toString(),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: index >= 1 && index <= 100
                                ? size * 0.5
                                : size * 0.6,
                            fontFamily: "Baloo2",
                            height: .8,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "level",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size * 0.2,
                        fontFamily: "Baloo2",
                        height: .9,
                      ),
                    ),
                    SizedBox(height: size * 0.15),
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
