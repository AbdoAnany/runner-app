import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/GamificationBloc.dart';
import '../manager/GamificationEvent.dart';
import '../manager/GamificationState.dart';

class GamificationScreen extends StatelessWidget {
  final GamificationBloc gamificationBloc = GamificationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => gamificationBloc,
      child: Scaffold(
        appBar: AppBar(title: Text("User Progress")),
        body: BlocListener<GamificationBloc, GamificationState>(
          listener: (context, state) {
            if (state is XPUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("XP Updated!")));
            }
          },
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  gamificationBloc.add(UpdateXP(userId: "user123", xpToAdd: 50));
                },
                child: Text("Add XP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
