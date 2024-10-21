import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../dependency_injection.dart';
import '../manager/userpoint_bloc.dart';

class UserPointControlBlocProvider extends StatelessWidget {
  const UserPointControlBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserPointBloc>(
      create: (context) => locator<UserPointBloc>(),
      child: const UserPointControlScreen(),
    );
  }
}

class UserPointControlScreen extends StatefulWidget {
  const UserPointControlScreen({super.key});

  @override
  State<UserPointControlScreen> createState() => _UserPointControlScreenState();
}

class _UserPointControlScreenState extends State<UserPointControlScreen> {
  @override
  void initState() {

locator<UserPointBloc>().add(GetUserListEvent());
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserPointBloc, UserPointState>(
        builder: (context, state) {
          if (state is UserPointLoading) return LoadingWidget();
          if (state is UserDateListLoaded) {
            return ListView.builder(
              itemBuilder: (c, i) =>
                  Text(state.userList[i].name.toString()),
            );
          }
          return Container();
        },
      ),
    );
  }
}
