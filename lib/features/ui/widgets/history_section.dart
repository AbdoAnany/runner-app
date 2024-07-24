import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/style/color.dart';

import '../../blocs/runner_data/runner_data_bloc.dart';
import '../../blocs/runner_data/runner_data_event.dart';
import '../../blocs/runner_data/runner_data_state.dart';

// class HistorySection extends StatelessWidget {
//   final List<Map<String, dynamic>> runnerData;
//
//   HistorySection({required this.runnerData});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//
//       Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'History',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//
//
//         SizedBox(height: 10),
//         runnerData.isEmpty
//             ? Center(child: Text('No history available.'))
//             : ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: runnerData.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     leading: Icon(Icons.history),
//                     title: Text(runnerData[index]['name']),
//                     subtitle: Text('Time: ${runnerData[index]['time']}'),
//                   );
//                 },
//               ),
//       ],
//     );
//   }
// }


class HistorySection extends StatefulWidget {
  final bool viewHistory;
  final bool viewPopular;

  const HistorySection( {this.viewHistory=false,this.viewPopular=false,super.key});

  @override
  State<HistorySection> createState() => _RunnerDataScreenState();
}
final List<Map<String, dynamic>> historyData = [
  {'date': '2024-01-01',
    "kal":512,
    "steps": 114141,
    "pt": 0,
    "distance": 1000.0,  },

  {'date': '2024-01-02',
    "kal":512,
    "steps": 7447,
    "pt": 0,
    "distance": 101400.0,  },

  {'date': '2024-01-03',
    "kal":512,
    "steps": 474,
    "pt": 100,
    "distance": 1414.0,  },

];
class _RunnerDataScreenState extends State<HistorySection> {
  @override
  void initState() {
    BlocProvider.of<RunnerDataBloc>(context).add(LoadRunnerData(),);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        title: Text('History',style: AppStyle.textStyle16GWhiteW800,),
      ),
      body: SafeArea(
        child: BlocBuilder<RunnerDataBloc, RunnerDataState>(
          builder: (context, state) {
            print('ssssssssss');
            print(state);
            if (state is RunnerDataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RunnerDataLoaded) {
              //state.historyData.addAll(historyData.toList());
              return     Column(
                children: [

        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),

          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white.withOpacity(.17)),
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Iconsax.timer_1, color: AppColors.white),
              Text(
                NumberFormat('###').format(state.historyData.length).toString()+' H',
                style: AppStyle.textStyle20GWhiteW800,
              ),
              Text(
                'Time',
                style: AppStyle.textStyle12GrayW400,
              ),
            ],
          ),
          Column(
            children: [
              Icon(Iconsax.routing, color: AppColors.white),
              Text(
                NumberFormat('###,#').format(state.historyData.fold(0,
                        (accumulator, element) => (accumulator + element['distance']).toInt())/1000)
                    +' KM',
                style: AppStyle.textStyle20GWhiteW800,
              ),
              Text(
                'distance',
                style: AppStyle.textStyle12GrayW400,
              ),
            ],
          ),
          Column(
            children: [
              Icon(Iconsax.heart_circle, color: AppColors.dotColor,size: 20.h,),
              Text(
                NumberFormat('###').format(state.historyData.fold(0, (accumulator, element) =>
                (accumulator + element['pt']).toInt()

                )).toString()+' BPM',
                style: AppStyle.textStyle20GWhiteW800,
              ),
              Text(
                'Heart Beat',
                style: AppStyle.textStyle12GrayW400,
              ),
            ],
          ),
        ],
          ),
        ),
                  Expanded(
                    child: historyData.isEmpty
                        ? Center(child: Text('No history available.'))
                        : ListView.builder(
                      shrinkWrap: true,
                      itemCount:  state.historyData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.bgContainerColor,
                            border: Border.all(color: AppColors.border1ContainerColor),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                          padding: const EdgeInsets.all(16.0),
                          child: Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text( DateFormat('dd MMM').format(DateTime.parse(state.historyData[index]['date']))  ,style: AppStyle.textStyle14PrimaryW400,),
                                Row(children: [
                                  if(state.historyData[index]['pt']>0)
                                  Text('PT '+ state.historyData[index]['pt'].toString(),
                                    style: AppStyle.textStyle12PinkW400,),
                                  if(state.historyData[index]['pt']>0)      Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: CircleAvatar(radius: 2,backgroundColor: AppColors.textGray,),
                                  ),
                                  Text( (state.historyData[index]['distance']/1000).toStringAsFixed(2)+" km"  ,style: AppStyle.textStyle12GrayW400,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: CircleAvatar(radius: 2,backgroundColor: AppColors.textGray,),
                                  ),
                                  Text( state.historyData[index]['kal'].toString() + " kcal",  style: AppStyle.textStyle12GrayW400,),
                                ],)
                              ],
                            ),
                    Spacer(),
                            Text(NumberFormat("#,###").format( state.historyData[index]['steps']).toString(),style: AppStyle.textStyleNormal21WhiteW700,),
                            Text(' steps',style: AppStyle.textStyle14WhiteW400,),

                          ],),
                        );
                      },
                    ),
                  ),
                ],
              );

                // ListView(
                // children: [
                //  // if (widget.viewHistory ?? false)
                //
                //
                //   // if (widget.viewPopular ?? false)
                //   //   PopularSection(popularData: state.popularData),
                // ],);

            } else {
              return Center(child: Text('Error loading data.'));
            }
          },
        ),
      ),
    );
  }
}

