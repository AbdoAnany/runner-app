import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/ClanMember.dart';
import '../../data/models/ClanRequest.dart';
import '../manager/ClanBloc.dart';
import '../manager/ClanEvent.dart';
import '../manager/ClanState.dart';



// models/clan_request.dart
import 'ClanScreen.dart';


// bloc/clan_event.dart


// screens/create_clan_screen.dart
class CreateClanScreen extends StatefulWidget {
  const CreateClanScreen({super.key});

  @override
  State<CreateClanScreen> createState() => _CreateClanScreenState();
}

class _CreateClanScreenState extends State<CreateClanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _maxMembersController = TextEditingController(text: '50');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Clan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Clan Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a clan name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _maxMembersController,
              decoration: const InputDecoration(
                labelText: 'Maximum Members',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Create Clan'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ClanBloc>().add(
            CreateClan(
              name: _nameController.text,
              description: _descriptionController.text,
              maxMembers: int.parse(_maxMembersController.text),
            ),
          );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _maxMembersController.dispose();
    super.dispose();
  }
}

// screens/clan_details_screen.dart
class ClanDetailsScreen extends StatelessWidget {
  final String clanId;

  const ClanDetailsScreen({super.key, required this.clanId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClanBloc()..add(LoadClan(clanId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Clan Details'),
          actions: [
            BlocBuilder<ClanBloc, ClanState>(
              builder: (context, state) {
                if (state is ClanLoaded) {
                  return _buildActionsMenu(context, state.clan);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<ClanBloc, ClanState>(
          builder: (context, state) {
            if (state is ClanLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ClanLoaded) {
              return _buildClanDetails(context, state.clan);
            }
            return const Center(child: Text('Failed to load clan details'));
          },
        ),
      ),
    );
  }

  Widget _buildClanDetails(BuildContext context, Clan clan) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (clan.imageUrl != null)
          Card(
            child: Image.network(
              clan.imageUrl!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clan.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(clan.description),
                const SizedBox(height: 16),
                Text(
                  'Members: ${clan.members.length}/${clan.maxMembers}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Created: ${DateFormat.yMMMd().format(clan.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (clan.canManageRequests("user123")) // TODO: Get current user ID
          _buildJoinRequestsSection(context, clan),
        const SizedBox(height: 16),
        _buildMembersSection(clan),
      ],
    );
  }

  Widget _buildJoinRequestsSection(BuildContext context, Clan clan) {
    if (clan.joinRequests.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No pending join requests'),
        ),
      );
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Join Requests',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: clan.joinRequests.length,
            itemBuilder: (context, index) {
              final request = clan.joinRequests[index];
              return ListTile(
                title: Text(request.userName),
                subtitle: Text(request.message),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        context.read<ClanBloc>().add(
                              HandleJoinRequest(request.id, true),
                            );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        context.read<ClanBloc>().add(
                              HandleJoinRequest(request.id, false),
                            );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMembersSection(Clan clan) {
    return Card(
      child: Column(
        children: [
          ...clan.members.map((member) => ListTile(
                leading: CircleAvatar(
                  child: Text(member.name[0]),
                ),
                title: Text(member.name),
                subtitle: Text(member.role.toString().split('.').last),
                trailing: Text(
                  DateFormat.yMMMd().format(member.joinDate),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildActionsMenu(BuildContext context, Clan clan) {
    final currentUserId = "user123"; // TODO: Get from auth
    if (clan.isLeader(currentUserId) || clan.isCoLeader(currentUserId)) {
      return PopupMenuButton<String>(
        onSelected: (value) {
          switch (value) {
            case 'invite':
              _showInviteDialog(context);
              break;
            case 'edit':
              _showEditClanDialog(context, clan);
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'invite',
            child: Text('Invite Member'),
          ),
          const PopupMenuItem(
            value: 'edit',
            child: Text('Edit Clan'),
          ),
        ],
      );
    }
    return IconButton(
      icon: const Icon(Icons.person_add),
      onPressed: () => _showJoinRequestDialog(context),
    );
  }

  void _showJoinRequestDialog(BuildContext context) {
    final messageController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Request'),
        content: TextField(
          controller: messageController,
          decoration: const InputDecoration(
            labelText: 'Message to clan leaders',
            hintText: 'Why do you want to join this clan?',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ClanBloc>().add(
                    SendJoinRequest(clanId, messageController.text),
                  );
              Navigator.pop(context);
            },
            child: const Text('Send Request'),
          ),
        ],
      ),
    );
  }

  void _showInviteDialog(BuildContext context) {
    final userIdController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invite Member'),
        content: TextField(
          controller: userIdController,
          decoration: const InputDecoration(
            labelText: 'User ID',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ClanBloc>().add(
                    InviteMember(userIdController.text),
                  );
              Navigator.pop(context);
            },
            child: const Text('Send Invite'),
          ),
        ],
      ),
    );
  }

  void _showEditClanDialog(BuildContext context, Clan clan) {
    // Implement edit clan dialog
  }
}