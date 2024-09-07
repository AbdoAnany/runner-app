import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/game.dart';
import '../../../../core/style/app_style.dart';
import '../../../../dependency_injection.dart';
import '../../../3_home/presentation/widgets/home_progress_level_steps_bar.dart';
import '../manager/bloc/runner_data_bloc.dart';
import '../manager/bloc/runner_data_event.dart';
import '../manager/bloc/runner_data_state.dart';
import '../widgets/history_list.dart';
import '../widgets/statistics_widget.dart';

class HistoryScreenBlocProvider extends StatelessWidget {
  const HistoryScreenBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryDataBloc>(
      create: (context) => locator<HistoryDataBloc>(),
      child: const HistoryScreen(),
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
    context.read<HistoryDataBloc>() .add(LoadHistoryData());
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HistoryDataBloc, HistoryDataState>(
      builder: (context, state) {
        if (state is HistoryDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HistoryDataLoaded) {

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeProgressLevelStepsBar(levelSystem:state. levelSystem,),

              StatisticsWidget(state: state),
              Expanded(
                child: state.historyData.isEmpty
                    ? Center(
                    child: Text(
                      'No history available.',
                      style: AppStyle.textStyle16GWhiteW800,
                    ))
                    : HistoryList(historyData: state.historyData),
              ),
            ],
          );
        } else if (state is HistoryDataError) {
          return Center(
              child: Text(
                state.message,textAlign: TextAlign.center,
                style: AppStyle.textStyle16GWhiteW800,
              ));
        } else {
          return Center(
              child: Text(
                'Error loading data.',textAlign: TextAlign.center,
                style: AppStyle.textStyle16GWhiteW800,
              ));
        }
      },
    );
  }
}
