
import 'package:flutter/material.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';

class LevelGallery extends StatefulWidget {
  const LevelGallery({super.key});

  @override
  State<LevelGallery> createState() => _LevelGalleryState();
}

class _LevelGalleryState extends State<LevelGallery> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 3,mainAxisSpacing: 0,crossAxisSpacing: 0,),
        children: List.generate(103, (index) {
          index=index+1;
          if(index==1){ return TopBadgeLevel(index: index,);}
          if(index==2){ return TopBadgeLevel(index: index,);}
          if(index==3){ return TopBadgeLevel(index: index,);}
          if(index==10){ return TopBadgeLevel(index: index,);}
          if(index==50){ return TopBadgeLevel(index: index,);}
          if(index==100){ return TopBadgeLevel(index: index,);}

           return TopBadgeLevelGen(index: index,);

        }),
      ),
    );
  }
}
class TopBadgeLevel extends StatelessWidget {
 final int index;
  const TopBadgeLevel({super.key,  this. index=0});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,width: 140,

        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AppImage.topRank(index)))
    ),  );
  }
}

class TopBadgeLevelGen extends StatelessWidget {
  final int index;
  const TopBadgeLevelGen({Key? key, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;

        return Container(
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
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    index.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: size * 0.38,
                      fontFamily: "Baloo2",
                      height: 0.8,
                    ),
                  ),
                ),
              ),
              Text(
                "Top",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size * 0.086,
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
