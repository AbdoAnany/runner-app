import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/style/app_style.dart';
import '../../../../dependency_injection.dart';
import '../../data/models/ClanRequest.dart';
import '../manager/ClanBloc.dart';
import '../manager/ClanState.dart';

class ClanScreenBlocProvider extends StatelessWidget {
  const ClanScreenBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClanCubit>(
      create: (_) => ClanCubit()..getClans(),
      child: const ClanScreen(), // Ensure ClanScreen is a child of BlocProvider
    );
  }
}

class ClanScreen extends StatelessWidget {
  const ClanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clan Management", style: AppStyle.fWhiteS16W800),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateClanDialog(context),
          ),
        ],
      ),
      body: BlocConsumer<ClanCubit, ClanState>(
        listener: (context, state) {
          if (state is ClanError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ClanCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Clan created successfully!")),
            );
          } else if (state is ClanDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Clan deleted successfully!")),
            );
          }
        },
        builder: (context, state) {
          if (state is ClanLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ClanLoaded) {
            return _buildClanContent(context, state.clans);
          }
          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }

  Widget _buildClanContent(BuildContext context, List<Clan> clans) {
    return ListView.builder(
      itemCount: clans.length,
      padding: EdgeInsets.only(bottom: 60.h),
      itemBuilder: (context, index) {
        final clan = clans[index];
        return _buildClanInfo(clan, context);
      },
    );
  }

  Widget _buildClanInfo(Clan clan, BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to clan details screen
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ClanDetailsScreen(clanId: clan.id)));
      },
      child: Card(
        margin: const EdgeInsets.all(8),
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
              Text("ID: ${clan.id}"),
              Text("Description: ${clan.description}"),
              const SizedBox(height: 8),
              Text("Members: ${clan.members.length}/${clan.maxMembers}"),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _showDeleteClanDialog(context, clan.id),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateClanDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final maxMembersController = TextEditingController();

    showDialog(
      context: context,
      builder: (context1) => AlertDialog(
        title: const Text("Create Clan"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Clan Name"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: maxMembersController,
              decoration: const InputDecoration(labelText: "Max Members"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              final description = descriptionController.text.trim();
              final maxMembers = int.tryParse(maxMembersController.text.trim()) ?? 50;

              if (name.isNotEmpty && description.isNotEmpty) {
                context.read<ClanCubit>().createClan(
                  name: name,
                  description: description,
                  maxMembers: maxMembers,
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill all fields")),
                );
              }
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showDeleteClanDialog(BuildContext context, String clanId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Clan"),
        content: const Text("Are you sure you want to delete this clan?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context.read<ClanCubit>().deleteClan(clanId);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}