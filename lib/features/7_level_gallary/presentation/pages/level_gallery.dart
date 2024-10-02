
import 'package:flutter/material.dart';
import 'package:runner_app/features/7_level_gallary/presentation/widgets/TopBadgeLevel.dart';



class LevelGallery extends StatefulWidget {
  const LevelGallery({super.key});

  @override
  State<LevelGallery> createState() => _LevelGalleryState();
}

class _LevelGalleryState extends State<LevelGallery> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView(

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 3,mainAxisSpacing: 0,crossAxisSpacing: 0,),
        children: List.generate(103, (index) {
          index=index+1;
          if(index==1){ return TopBadgeLevel(index: index,);}
          if(index==2){ return TopBadgeLevel(index: index,);}
          if(index==3){ return TopBadgeLevel(index: index,);}
          // if(index==10){ return TopBadgeLevel(index: index,);}
          // if(index==50){ return TopBadgeLevel(index: index,);}
          // if(index==100){ return TopBadgeLevel(index: index,);}

           return TopBadgeLevelGen(index: index,);

        }),
      ),
    );
  }
}
