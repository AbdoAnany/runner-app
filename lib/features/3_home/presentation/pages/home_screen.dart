import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kg_charts/kg_charts.dart';
import 'package:runner_app/features/3_home/presentation/bloc/home_bloc.dart';

import '../../../../core/const/const.dart';
import '../../../../core/notification/notification_bloc.dart';
import '../../../../core/service/NotificationService.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [

            Container(
              height: 260.h,
              decoration:  const BoxDecoration(
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

          HomePage(),

          ShareAndGiftWidget(),
        ],
      ),
    );
  }
}


class EmployeePerformanceWidget extends StatelessWidget {
  final String employeeName;
  final String rank;
  final double progress;
  final String avatarUrl;

  EmployeePerformanceWidget({
    required this.employeeName,
    required this.rank,
    required this.progress,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Employee Info
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employeeName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rank: $rank',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Progress Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Performance',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                color: _getProgressColor(progress),
              ),

              SizedBox(height: 16),

              // Badges
              RadarWidget(
                radarMap: RadarMapModel(
                  legend: [
                    LegendModel('10/10',const Color(0XFF0EBD8D)),
                    LegendModel('10/11',const Color(0XFFEAA035)),
                  ],
                  indicator: [
                    IndicatorModel("English",100),
                    IndicatorModel("Physics",100),
                    IndicatorModel("Chemistry",100),
                    IndicatorModel("Biology",100),
                    IndicatorModel("Politics",100),
                    IndicatorModel("History",100),
                  ],
                  data: [
                    //   MapDataModel([48,32.04,1.00,94.5,19,60,50,30,19,60,50]),
                    //   MapDataModel([42.59,34.04,1.10,68,99,30,19,60,50,19,30]),
                    MapDataModel([100,90,90,90,10,20]),
                    MapDataModel([90,90,90,90,10,20]),
                  ],
                  radius: 130,
                  duration: 2000,
                  shape: Shape.square,
                  maxWidth: 70,
                  line: LineModel(4),
                ),
                textStyle: const TextStyle(color: Colors.black,fontSize: 14),
                isNeedDrawLegend: true,
                lineText: (p,length) =>  "${(p*100~/length)}%",
                dilogText: (IndicatorModel indicatorModel,List<LegendModel> legendModels,List<double> mapDataModels) {
                  StringBuffer text = StringBuffer("");
                  for(int i=0;i<mapDataModels.length;i++){
                    text.write("${legendModels[i].name} : ${mapDataModels[i].toString()}");
                    if(i!=mapDataModels.length-1){
                      text.write("\n");
                    }
                  }
                  return text.toString();
                },
                outLineText: (data,max)=> "${data*100~/max}%",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to determine color based on progress
  Color _getProgressColor(double progress) {
    if (progress >= 0.8) return Colors.green;
    if (progress >= 0.5) return Colors.orange;
    return Colors.red;
  }
}

class HomePage extends StatelessWidget {

  const HomePage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationReceived) {
                return Text('Latest XP Update: ${state.updatedEntry?.xp}');
              }
              return Text('Waiting for updates...');
            },
          ),
          SizedBox(height: 20),
          EmployeePerformanceWidget(employeeName: 'Abdo',
            progress: 1000, rank: 'SS',
            avatarUrl: AppImage.avatarUrl,
          ),
          // Button to send a test notification
          ElevatedButton(
            onPressed: () async {
              String? token = await FirebaseMessaging.instance.getToken();
              print(token);
              if (token != null) {
                locator<NotificationService>().sendNotification(
                  title: 'Dynamic Notification',
                  topic: '/topics/test',
                  message: 'This is a test of dynamic data!',
                   registrationTokens: token,
                  data: {
                    'xp': '100',
                    'topic': '/topics/test',
                    'customField': {"data123": "dataMess"},
                  },
                );
              } else {
                print('Unable to get FCM token');
              }
            },
            child: Text('Send Test Notification'),
          ),

          SizedBox(height: 20),

          // Button to subscribe to a topic
          ElevatedButton(
            onPressed: () async {
              await locator<NotificationService>().subscribeToTopic('test'); // Replace 'test' with your desired topic
              print('Subscribed to test topic');
            },
            child: Text('Subscribe to Topic'),
          ),

          SizedBox(height: 20),

          // Button to unsubscribe from a topic
          ElevatedButton(
            onPressed: () async {
              await locator<NotificationService>().unsubscribeFromTopic('test'); // Replace 'test' with your desired topic
              print('Unsubscribed from test topic');
            },
            child: Text('Unsubscribe from Topic'),
          ),
        ],
      ),
    );
  }
}
