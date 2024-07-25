import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../../dependency_injection.dart';
import '../manager/runner_data/runner_data_bloc.dart';
import '../manager/runner_data/runner_data_event.dart';
import '../manager/runner_data/runner_data_state.dart';
import '../widgets/history_list.dart';
import '../widgets/statistics_widget.dart';
class HistoryScreenBlocProvider extends StatelessWidget {
  const HistoryScreenBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
  return  BlocProvider<RunnerHistoryDataBloc>(
      create: (context) => locator<RunnerHistoryDataBloc>(),
      child:  HistoryScreen(),
    );
  }
}



class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}
class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RunnerHistoryDataBloc>(context).add(LoadRunnerData());
  }
  @override
  Widget build(BuildContext context) {
    return

      BlocBuilder<RunnerHistoryDataBloc, RunnerHistoryDataState>(
      builder: (context, state) {
        if (state is RunnerDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RunnerDataLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h,),
              StatisticsWidget(state: state,),

              Expanded(
                child: state.historyData.isEmpty
                    ? Center(child: Text('No history available.',
                  style: AppStyle.textStyle16GWhiteW800,))
                    : HistoryList(historyData: state.historyData),
              ),
            ],
          );
        }

        else if (state is RunnerDataError) {
          return Center(child: Text(state.message,
            style: AppStyle.textStyle16GWhiteW800,));
        } else {
          return Center(child: Text('Error loading data.',
            style: AppStyle.textStyle16GWhiteW800,));
        }
      },
    );
  }
}
