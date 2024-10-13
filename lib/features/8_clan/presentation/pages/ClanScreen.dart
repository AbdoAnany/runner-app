import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/ClanBloc.dart';
import '../manager/ClanEvent.dart';
import '../manager/ClanState.dart';

class ClanScreen extends StatelessWidget {
  final ClanBloc clanBloc = ClanBloc();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => clanBloc,
      child: Scaffold(
        appBar: AppBar(title: Text("Clan Management")),
        body: BlocListener<ClanBloc, ClanState>(
          listener: (context, state) {
            if (state is ClanRequestSent) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Request sent to clan!")));
            } else if (state is ClanInviteAccepted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invite accepted!")));
            }
          },
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  clanBloc.add(RequestToJoinClan(clanId: "123", userId: "user123"));
                },
                child: Text("Request to Join Clan"),
              ),
              ElevatedButton(
                onPressed: () {
                  clanBloc.add(AcceptInvite(clanId: "123", userId: "user123"));
                },
                child: Text("Accept Invite"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
