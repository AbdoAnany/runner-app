import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/style/app_style.dart';
import '../../data/models/ClanMember.dart';
import '../../data/models/ClanRequest.dart';
import '../../data/models/ClanRole.dart';
import '../manager/ClanBloc.dart';
import '../manager/ClanEvent.dart';
import '../manager/ClanState.dart';
import 'ClanDetailsScreen.dart';

class ClanScreen extends StatelessWidget {
  const ClanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClanBloc()..add(LoadClan("123")),
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Clan Management",style:  AppStyle.fWhiteS16W800,),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () => _showInviteDialog(context),
            ),
          ],
        ),
        body: BlocConsumer<ClanBloc, ClanState>(
          listener: (context, state) {
            if (state is ClanError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is ClanActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is ClanLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ClanLoaded) {
              return _buildClanContent(context, state.clan);
            }
            return const Center(child: Text("Something went wrong"));
          },
        ),
      ),
    );
  }

  Widget _buildClanContent(BuildContext context, Clan clan) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildClanInfo(clan,context),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildClanInfo(Clan clan,BuildContext context,) {
    return InkWell(
      onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => ClanDetailsScreen( clanId: clan.id))),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                clan.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(clan.description),
              const SizedBox(height: 8),
              Text("Members: ${clan.members.length}/${clan.maxMembers}"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMembersList(BuildContext context, Clan clan) {
    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: clan.members.length,
        itemBuilder: (context, index) {
          final member = clan.members[index];
          return ListTile(
            leading: CircleAvatar(child: Text(member.name[0])),
            title: Text(member.name),
            subtitle: Text(member.role.toString().split('.').last),
            trailing: _buildMemberActions(context, clan, member),
          );
        },
      ),
    );
  }

  Widget _buildMemberActions(BuildContext context, Clan clan, ClanMember member) {
    // Only show actions if current user is leader or co-leader
    final currentUserId = "user123"; // TODO: Get from auth
    if (!clan.isLeader(currentUserId) && !clan.isCoLeader(currentUserId)) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'promote':
            _showPromoteDialog(context, member);
            break;
          case 'remove':
            _showRemoveDialog(context, member);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'promote',
          child: Text('Promote'),
        ),
        const PopupMenuItem(
          value: 'remove',
          child: Text('Remove'),
        ),
      ],
    );
  }

  void _showInviteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Invite Member"),
        content: TextField(
          decoration: const InputDecoration(
            labelText: "User ID",
          ),
          onSubmitted: (value) {
            context.read<ClanBloc>().add(InviteMember(value));
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Handle invite
              Navigator.pop(context);
            },
            child: const Text("Invite"),
          ),
        ],
      ),
    );
  }

  void _showPromoteDialog(BuildContext context, ClanMember member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Promote Member"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Promote ${member.name} to:"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<ClanBloc>().add(
                  PromoteMember(member.id, ClanRole.coLeader),
                );
                Navigator.pop(context);
              },
              child: const Text("Co-Leader"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, ClanMember member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Remove Member"),
        content: Text("Are you sure you want to remove ${member.name}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context.read<ClanBloc>().add(RemoveMember(member.id));
              Navigator.pop(context);
            },
            child: const Text("Remove"),
          ),
        ],
      ),
    );
  }
}