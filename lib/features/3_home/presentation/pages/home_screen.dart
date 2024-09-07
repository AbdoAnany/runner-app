import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/features/3_home/presentation/bloc/home_bloc.dart';

import '../../../../core/const/const.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../dependency_injection.dart';
import '../widgets/dayliy_activity_card.dart';
import '../widgets/home_progress_level_steps_bar.dart';
import '../widgets/share_and_gift_.dart';
import '../widgets/total_point_and_steps.dart';


class HomeScreenBlocProvider extends StatelessWidget {
  const HomeScreenBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => locator<HomeBloc>(),
      child: const HomeScreen(),
    );
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          context.read<HomeBloc>().add(LoadHomeData());

          return LoadingWidget();
        } else if (state is HomeLoading) {
          return LoadingWidget();
        } else if (state is HomeLoaded) {

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(RefreshHomeData());
            },
            child: const HomeScreenBody(),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

          Container(
            height: 260.h,
            decoration:  BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage(AppImage.homeGrenadianImage),
              //   fit: BoxFit.fill,
              // ),
             // color: Colors.blue.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child:     const Column(
              children: [
                // header have name and avatar and message button
                // HomeAppBar(),
                // progress bar , total steps and Level

                // daily activity points
                DailyActivityCard(),
                // Total point and steps
                TotalPointAndSteps(),
                // Gift image

              ],
            ),
          ),



        ShareAndGiftWidget(),
      ],
    );
  }
}
