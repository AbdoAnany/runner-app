import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/runner_data/runner_data_bloc.dart';
import '../../blocs/runner_data/runner_data_event.dart';
import '../../blocs/runner_data/runner_data_state.dart';
import '../widgets/history_section.dart';
import '../widgets/popular_section.dart';

class RunnerDataScreen extends StatefulWidget {
  final bool viewHistory;
  final bool viewPopular;

  const RunnerDataScreen( {this.viewHistory=false,this.viewPopular=false,super.key});

  @override
  State<RunnerDataScreen> createState() => _RunnerDataScreenState();
}

class _RunnerDataScreenState extends State<RunnerDataScreen> {
  @override
  void initState() {
    BlocProvider.of<RunnerDataBloc>(context).add(LoadRunnerData(),);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RunnerDataBloc, RunnerDataState>(
      builder: (context, state) {
        if (state is RunnerDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RunnerDataLoaded) {
          return ListView(
            children: [
           //   if (widget.viewHistory ?? false)
               // HistorySection(runnerData: state.historyData),
           //   if (widget.viewPopular ?? false)
                // StoreSection(popularData: state.popularData),
            ],
          );
        } else {
          return Center(child: Text('Error loading data.'));
        }
      },
    );
  }
}
